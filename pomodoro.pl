#!/usr/bin/perl

use strict;
use warnings;
use constant WORK_TIME => 25 * 60;
use constant BREAK_TIME => 5 * 60;

my $toWork = "xset dpms force on";
my $toBreak = "xset dpms force off";
my $shift = WORK_TIME;
my $isWorking = 1;


while( 1 )
{ 
    if ($isWorking)
    {
        
        $shift = WORK_TIME;
        print "Go to work\n";
        qx{ $toWork };
    }
    else
    {
        print "Go to break\n";
        $shift = BREAK_TIME;
        qx{ $toBreak };
    }
    $isWorking = 1 - $isWorking;
    my $now = time;
    my $endtime = $now + $shift;
    
    sleep $endtime - $now
}

