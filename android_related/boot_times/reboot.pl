use Time::HiRes qw(time);
open BOOTTIME_LOGS, ">boot_times.log" or die $!;

sub isRebootComplete ()
{
	my @isRebootDoneCheck =`(adb shell dumpsys SurfaceFlinger | grep com.android.launcher/com.android.launcher2.Launcher) 2>&1`;
	chomp(@isRebootDoneCheck);
	my $isDeviceUp = @isRebootDoneCheck;
	
	#my @isRebootDoneCheck =`adb shell ps | grep system_server`;
	# When launcher is not up
	if($isDeviceUp == 0)
	{
		return 0;
	}
	
	# When launcher is up
	else 
	{
		if ($isRebootDoneCheck[0] eq "error: device not found"){
			return 0;	
		}
		return 1;
	}
}	# end of sub isRebootComplete

sub reboot_run(){

	my $iterations = 1000;
	print BOOTTIME_LOGS "======================================================\n";
	print BOOTTIME_LOGS "Measuring boot time of $iterations iterations of reboot\n";
	print BOOTTIME_LOGS "======================================================\n\n";
	for(my $i=1; $i<=$iterations; $i++)

	{
		print "APT Feature Test[log]: Rebooting the target Iteration $i of $iterations \n"; 
		my $start_time = time();

		system("adb shell reboot");
		sleep(5);
	
		my $countDeviceMatches =()= `adb devices | grep -E device\$`;

		if($countDeviceMatches > 0)
		{
		   print "APT Feature Test[log]: Adb Reboot failed. Exiting. \n";
		   exit -1;
		}
	
	
		my $maxRetries = 60;
		my $ct = 0;
		my $rebootSuccess = -1;
		while($ct++ < 60)
		{
			my $rebootdone = &isRebootComplete();

			if($rebootdone == 1)
		    {
				$rebootSuccess = 1;
				my $end_time = time();
				my $reboot_time = sprintf("%.3f", $end_time - $start_time);
				print "\n\nIteration $i - Reboot Time = $reboot_time s\n\n";
				print BOOTTIME_LOGS "Iteration $i - Reboot Time = $reboot_time s\n";
				last;
			}
			sleep(1);
		}		# End of reboot retry loop
	
	
		if($rebootSuccess == -1)
		{ 
			print "\nAPT Feature Test[log]: Reboot failed at iteration $i. Exiting. \n";
			exit -1;
		}
	} # end of for loop

	exit 0;
}

reboot_run();
