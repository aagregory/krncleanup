#!/usr/bin/perl

#Clean up old unused kernels on your Ubuntu system.
#leave current running kernel intact and don't touch non-kernel packages.
#Gregory at allsbe.com
#
#
#

use Getopt::Long;

$date 		= localtime();
$currversion 	= `uname -r`;
$krncleanlog	= 'krncleaner.log';

GetOptions(

"c"   => \$clean,
"y"   => \$quiet,
"h"   => \$help

	);

help() unless defined $clean;

print "Initializing for run at $date with options $clean, $quiet, $help \n";

if (defined $clean){
	chomp $currversion;
	open ('krncleanlog', ">$krncleanlog") or die $!;
	print krncleanlog "Going to start cleaning printing space usage before clean up....\n";
		open ('checkspace', "df -h |") or die $!;
			while ($checkspace = <checkspace>){
			print "$checkspace";
			print krncleanlog "$checkspace";
		}
		close (checkspace);
			if ($quiet){
				$silentcmd = 'sudo apt-get -y purge';
			}

	runner($silentcmd);
	print "Clean complete....\n";
	print krncleanlog "Clean complete printing free space....\n";
		open ('checkspace', "df -h |") or die $!;
			while ($checkspace = <checkspace>){
			print "$checkspace";
			print krncleanlog "$checkspace";
		}
		close (checkspace);
	close (krncleanlog);
		
}

exit;


sub runner{
	my $scmd = shift @_;

	unless (defined $scmd){
		$scmd = 'sudo apt-get purge';	
	}

	my ($runtimemajor, $runtimeminor, $runtimetype)	= split (/-/,$currversion);

	print "Current Version: $runtimemajor, $runtimeminor, $runtimetype\n";

	open ('installed', "dpkg -l linux-\* |") or die $!;
		while ($installed = <installed>){

			next unless $installed =~ /ii/i;			
			next if $installed =~ /${runtimemajor}(\.|\-)${runtimeminor}/;
			next unless $installed =~ /(linux-headers|linux-image)/i;
			
			my ($inst, $pkge, $ver, $platform, $notes) = split(' ', $installed);
			print krncleanlog "Preparing to remove: $pkge\n";			
			
			open ('purge', "${scmd} ${pkge} |") or die $!;
				while (my $purge = <purge>){
					print "$purge";
					print krncleanlog "$purge";
					}
			close (purge); 

			
		}

}


sub help{


print<<EOF


Summary:
A program to clean up old unused kernel versions on a Ubuntu based system.

Usage:
krncleanup.pl {-c} [-y] [-h]

Detailed Description:

-c    Clean, required option, you must pass this value to clean up otherwise the program will only print installed
      kernel versions, which may be useful diagnostic info.

-y    Really quiet, overrides the default interactive behavior, doesn't prompt for anything, otherwise press enter at 
      each pause or prompt to acknowledge and continue.

-h    Print help and exit.

Example:

krncleanup.pl -c -y

EOF
;



}
