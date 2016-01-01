#!/system/bin/sh
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

# Initial
mount -o remount,rw -t auto /
mount -t rootfs -o remount,rw rootfs
mount -o remount,rw -t auto /system
mount -o remount,rw /data
mount -o remount,rw /cache

if [ -f /system/xbin/busybox ]; then
	chown 0:2000 /system/xbin/busybox
	chmod 0755 /system/xbin/busybox
	/system/xbin/busybox --install -s /system/xbin
	ln -s /system/xbin/busybox /sbin/busybox
	ln -s /system/xbin/busybox /system/bin/busybox
	sync
fi

# Set environment and create symlinks: /bin, /etc, /lib, and /etc/mtab
set_environment ()
{
	# create /bin symlinks
	if [ ! -e /bin ]; then
		/system/xbin/busybox ln -s /system/bin /bin
	fi

	# create /etc symlinks
	if [ ! -e /etc ]; then
		/system/xbin/busybox ln -s /system/etc /etc
	fi

	# create /lib symlinks
	if [ ! -e /lib ]; then
		/system/xbin/busybox ln -s /system/lib /lib
	fi

	# symlink /etc/mtab to /proc/self/mounts
	if [ ! -e /system/etc/mtab ]; then
		/system/xbin/busybox ln -s /proc/self/mounts /system/etc/mtab
	fi
}

if [ -x /system/xbin/busybox ]; then
	set_environment
fi

#Set CPU Min Frequencies
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

#Set CPU Max Frequencies
echo 2496000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 2496000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 2496000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 2496000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq

#Set GPU Min Frequencies
echo 200000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq

#Set GPU Max Frequencies
echo 600000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq

# Interactive governor
chown -R system:system /sys/devices/system/cpu/cpu0/cpufreq/interactive
chmod -R 0666 /sys/devices/system/cpu/cpu0/cpufreq/interactive
chmod 0755 /sys/devices/system/cpu/cpu0/cpufreq/interactive
chown -R system:system /sys/devices/system/cpu/cpu1/cpufreq/interactive
chmod -R 0666 /sys/devices/system/cpu/cpu1/cpufreq/interactive
chmod 0755 /sys/devices/system/cpu/cpu1/cpufreq/interactive
chown -R system:system /sys/devices/system/cpu/cpu2/cpufreq/interactive
chmod -R 0666 /sys/devices/system/cpu/cpu2/cpufreq/interactive
chmod 0755 /sys/devices/system/cpu/cpu2/cpufreq/interactive
chown -R system:system /sys/devices/system/cpu/cpu3/cpufreq/interactive
chmod -R 0666 /sys/devices/system/cpu/cpu3/cpufreq/interactive
chmod 0755 /sys/devices/system/cpu/cpu3/cpufreq/interactive

# interactive Governor for Default
chown system system /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
chown system system /sys/devices/system/cpu/cpufreq/interactive/bimc_hispeed_freq
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/bimc_hispeed_freq
chown system system /sys/devices/system/cpu/cpufreq/interactive/boost
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/boost
chown system system /sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration
chown system system /sys/devices/system/cpu/cpufreq/interactive/enforced_mode
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/enforced_mode
chown system system /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
chown system system /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
chown system system /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
chown system system /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
chown system system /sys/devices/system/cpu/cpufreq/interactive/mode
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/mode
chown system system /sys/devices/system/cpu/cpufreq/interactive/multi_enter_load
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/multi_enter_load
chown system system /sys/devices/system/cpu/cpufreq/interactive/multi_enter_time
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/multi_enter_time
chown system system /sys/devices/system/cpu/cpufreq/interactive/multi_exit_load
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/multi_exit_load
chown system system /sys/devices/system/cpu/cpufreq/interactive/multi_exit_time
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/multi_exit_time
chown system system /sys/devices/system/cpu/cpufreq/interactive/param_index
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/param_index
chown system system /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
chown system system /sys/devices/system/cpu/cpufreq/interactive/single_enter_load
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/single_enter_load
chown system system /sys/devices/system/cpu/cpufreq/interactive/single_enter_time
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/single_enter_time
chown system system /sys/devices/system/cpu/cpufreq/interactive/single_exit_load
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/single_exit_load
chown system system /sys/devices/system/cpu/cpufreq/interactive/single_exit_time
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/single_exit_time
chown system system /sys/devices/system/cpu/cpufreq/interactive/sync_freq
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/sync_freq
chown system system /sys/devices/system/cpu/cpufreq/interactive/target_loads
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/target_loads
chown system system /sys/devices/system/cpu/cpufreq/interactive/timer_rate
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/timer_rate
chown system system /sys/devices/system/cpu/cpufreq/interactive/timer_slack
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/timer_slack
chown system system /sys/devices/system/cpu/cpufreq/interactive/up_threshold_any_cpu_freq
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/up_threshold_any_cpu_freq
chown system system /sys/devices/system/cpu/cpufreq/interactive/up_threshold_any_cpu_load
chmod 0660 /sys/devices/system/cpu/cpufreq/interactive/up_threshold_any_cpu_load

chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod -h 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod -h 0664 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod -h 0664 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo "interactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
chmod -h 0664 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
chmod -h 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor "interactive"
chmod -h 0664 /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor "interactive"
chmod -h 0664 /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
chmod 777 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor "interactive"
chmod -h 0664 /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
 
sleep 0.5s

sync

# Initialice SQlite
/res/ext/sqlite.sh

# Initialice Zipalign
/res/ext/zipalign.sh

# Kernel panic setup
if [ -e /proc/sys/kernel/panic_on_oops ]; then 
	echo "0" > /proc/sys/kernel/panic_on_oops
fi
if [ -e /proc/sys/kernel/panic ]; then 
	echo "0" > /proc/sys/kernel/panic
fi
if [ -e /proc/sys/vm/panic_on_oom ]; then 
	 echo "0" > /proc/sys/vm/panic_on_oom
fi

# Fast Charge
echo "1" > /sys/kernel/fast_charge/force_fast_charge

sync

sleep 0.2s

# Fix permissions
chmod 0664 /sys/module/lowmemorykiller/parameters/minfree
chmod 0664 /sys/module/lowmemorykiller/parameters/adj

sync

sleep 0.2s

# IO_tweak
LOOP=`ls -d /sys/block/loop* 2>/dev/null`
RAM=`ls -d /sys/block/ram* 2>/dev/null`
MMC=`ls -d /sys/block/mmc* 2>/dev/null`
ZSWA=`ls -d /sys/block/vnswap* 2>/dev/null`
for j in $LOOP $RAM $MMC $ZSWA
do 
	if [ -e $j/queue/rotational ]; then
		echo "0" > $j/queue/rotational
	fi
	if [ -e $j/queue/iostats ]; then
		echo "0" > $j/queue/iostats
	fi
	if [ -e $j/queue/nr_requests ]; then
		echo "1024" > $j/queue/nr_requests
	fi
	if [ -e $j/queue/read_ahead_kb ]; then
		echo "2048" > $j/queue/read_ahead_kb
	fi
	if [ -e $j/bdi/read_ahead_kb ]; then
		echo "2048" > $j/bdi/read_ahead_kb
        fi
done

echo "2048" > /sys/devices/virtual/bdi/179:0/read_ahead_kb

sleep 0.5s

sync

stop thermal-engine
/system/xbin/busybox run-parts /system/etc/init.d
start thermal-engine

sync

sleep 0.2s


busy=/sbin/busybox;

# lmk tweaks for fewer empty background processes
minfree=1024,2048,4096,8192,12288,16384;
lmk=/sys/module/lowmemorykiller/parameters/minfree;
minboot=`cat $lmk`;
while sleep 1; do
  if [ `cat $lmk` != $minboot ]; then
    [ `cat $lmk` != $minfree ] && echo $minfree > $lmk || exit;
  fi;
done &

sleep 0.5s

sync

# Disable Dynamic FSync
chmod 0777 /sys/kernel/dyn_fsync/Dyn_fsync_active
echo "0" > /sys/kernel/dyn_fsync/Dyn_fsync_active
chmod 0664 /sys/kernel/dyn_fsync/Dyn_fsync_active

# Disable Simple GPU Algorithm
chmod 0777 /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
echo "0" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
chmod 0664 /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate

# Enable Adreno Idler
chmod 0777 /sys/module/adreno_idler/parameters/adreno_idler_active
echo "1" > /sys/module/adreno_idler/parameters/adreno_idler_active
chmod 0664 /sys/module/adreno_idler/parameters/adreno_idler_active

# Disable State Notifier
chmod 0777 /sys/module/state_notifier/parameters/enabled
echo "0" > /sys/module/state_notifier/parameters/enabled
chmod 0664 /sys/module/state_notifier/parameters/enabled

# Enable adaptive lmk
chmod 0777 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo "1" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
chmod 0664 /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

# Debug level
if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
    chmod 0777 /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
    chmod 0644 /sys/module/lowmemorykiller/parameters/debug_level
  fi

sleep 0.5s

sync

# Now wait for the rom to finish booting up
# (by checking for any android process)
while ! pgrep android.process.acore ; do
  sleep 2
done

# Google play services wakelock fix
sleep 40
su -c "pm enable com.google.android.gms/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver"
su -c "pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver"


mount -o remount,ro -t auto /
mount -t rootfs -o remount,ro rootfs
mount -o remount,ro -t auto /system
mount -o remount,rw /data
mount -o remount,rw /cache
