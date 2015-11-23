#!/bin/bash
#   initial parse script to map HBA to devices and used by fc_host perl script.
#
#    Copyright (C) 2015  Allan McAleavy
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
#   (http://www.gnu.org/copyleft/gpl.html)
#   23-11-2015 Allan McAleavy Created this.
#
#

mkdir ./targets
rm ./targets/*

KERNEL=`uname -r | awk -F"." '{print $6}'`

if [ "${KERNEL}" == "el5" ]
then
   echo "RHEL 5"

for i in `ls -ltr /sys/block/sd*/device |sed 's/\// /g' |awk '{print $20}' |sort -u`
do
   if [ -a "./fc_${i}" ]
   then
       rm ./fc_${i}
   fi
   i=`echo $i |sed 's/://g'`
   touch ./targets/fc_${i}
done

ls -ltr /sys/block/sd*/device  |while  read line
do
   host=`echo $line |sed 's/\// /g' |awk '{print $20}' |sed 's/://g'`
   disk=`echo $line |sed 's/\// /g' |awk '{print $11}'`
   echo $disk $host
   if [ -a "./targets/fc_${host}" ]
   then
      echo $disk >> ./targets/fc_${host}
   fi
done

else

for i in `ls -ltr /sys/block/sd* |sed 's/\// /g' |awk '{print $18}' |sort -u`
do
   if [ -a "./fc_${i}" ]
   then
       rm ./fc_${i}
   fi
   i=`echo $i |sed 's/://g'`
   touch ./targets/fc_${i}
done


ls -ltr /sys/block/sd*  |while  read line
do
   host=`echo $line |sed 's/\// /g' |awk '{print $18}' |sed 's/://g'`
   disk=`echo $line |sed 's/\// /g' |awk '{print $11}'`
   echo $disk $host
   if [ -a "./targets/fc_${host}" ]
   then
      echo $disk >> ./targets/fc_${host}
   fi
done
fi
