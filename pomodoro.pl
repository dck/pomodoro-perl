#!/usr/bin/perl

use strict;
use warnings;
use constant WORK_TIME => 30; # just useful for me
use constant BREAK_TIME => 10; #

my $toWork = "vbetool dpms on";
my $toBreak = "vbetool dpms off";
my $shift = WORK_TIME;
my $isWorking = 1;


while( 1 )
{ 
    if ($isWorking) {
        $shift = WORK_TIME;
        qx{ $toWork };
    } else {
        $shift = BREAK_TIME;
        qx{ $toBreak };
    }
    $isWorking = 1 - $isWorking;
    my $now = time;
    my $endtime = $now + $shift;
    
    sleep $endtime - $now
}

