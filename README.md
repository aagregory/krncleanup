#krncleanup.pl

##Summary

A script I use on my workstations and servers to clean up old unused Ubuntu kernel installs.  
This will clear out all old kernels leaving only the current versions as found in the grub config.
Use this at your own risk.  This requires an installed version of Perl, admin privs, and a few Perl
modules.  Feel free to improve this as you see areas which can be improved.

##Usage

Summary:
A program to clean up old unused kernel versions on a Ubuntu based system, leaving the current version intact.

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


##Notes and use warnings, about this script.
To run from a bash terminal:
1.  clone the repo git clone https://github.com/gregory-at-allsbecom/krncleanup.git
2.  chmod 0755 krncleanup.pl
3.  From bash execute krncleanup.pl, with the appropriate usage flags. 
