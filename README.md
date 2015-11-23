# fc_stat
iostat parser for linux to show HBA throughput. 

To run , we first need to get a mapping of devices to HBAs this is done by parsing the /sys/block/<dev> symbolic link or by looking at the /sys/block/<dev>/device link.

## fc_map.ksh 

We run this script first to map the device to hba.

<pre> <b> ./fc_map.ksh </b>
mkdir: cannot create directory `./targets': File exists
sdc host3
sdb host3
sda host2
sds host4
sdr host4
sdq host4
sdp host4
sdo host4
</pre>

<pre> <b> cd targets ; ls ; more fc_host3 </b> 
$ ls
fc_host2  fc_host3  fc_host4  fc_target1000  fc_target1100  fc_target1200  fc_target900
$ more fc_host3
sdc
sdb
sdm
sdl
sdk
sdj
sdi
sdh
sdg
sdf
sde
sdd

</pre>

## fc_stat

We then run the main script with an interval and count, the default will be 1 second interval for 9999 iterations. 

<pre># <b>./fc_stat</b> 
Time         Target        Reads   Writes     IOPS  Read MB Write MB   Tot MB Max Await  Max Svc
-------------------------------------------------------------------------------------------------
17:27:53       fc_host2        0       34       34        0        1        1     1.71     1.38
17:27:53       fc_host3     1516        1     1517      176        0      176     1.46     1.08
17:27:53       fc_host4      970        1      971      113        0      113     1.16     0.95
17:27:53  fc_target1000        0        0        0        0        0        0     0.00     0.00
17:27:53  fc_target1100        0        0        0        0        0        0     0.00     0.00
17:27:53  fc_target1200        0        0        0        0        0        0     0.00     0.00
17:27:53   fc_target900        0        0        0        0        0        0     0.00     0.00
Time         Target        Reads   Writes     IOPS  Read MB Write MB   Tot MB Max Await  Max Svc
-------------------------------------------------------------------------------------------------
17:27:54       fc_host2        1       13       14        0        0        0     1.71     1.71
17:27:54       fc_host3     1141        1     1142      128        0      128     1.77     1.46
17:27:54       fc_host4      790        2      792       89        0       89     1.96     1.52
17:27:54  fc_target1000        0        0        0        0        0        0     0.00     0.00
17:27:54  fc_target1100        0        0        0        0        0        0     0.00     0.00
17:27:54  fc_target1200        0        0        0        0        0        0     0.00     0.00
17:27:54   fc_target900        0        0        0        0        0        0     0.00     0.00
</pre>

The await and service_time is the maximum for all devices in the sampled period.
