#!/usr/bin/perl

use strict;
use warnings;
use constant WORK_TIME  => 25 * 60;
use constant BREAK_TIME =>  6 * 60;

my $commandsToWork = [
        "xinput --set-prop 11 \"Device Enabled\" \"1\"",
        "xinput --set-prop 9 \"Device Enabled\" \"1\"",
        "xinput --set-prop 15 \"Device Enabled\" \"1\"",
        "xinput --set-prop 14 \"Device Enabled\" \"1\"",
        "xset dpms force on"
    ];
my $commandsToBreak = [
        "xinput --set-prop 11 \"Device Enabled\" \"0\"",
        "xinput --set-prop 9 \"Device Enabled\" \"0\"",
        "xinput --set-prop 15 \"Device Enabled\" \"0\"",
        "xinput --set-prop 14 \"Device Enabled\" \"0\"",
        "xset dpms force off"
    ];
# my $toWork = "vbetool dpms on";
# my $toBreak = "vbetool dpms off";
my $shift = WORK_TIME;
my $isWorking = 1;

while( 1 )
{ 
    if ($isWorking) {
        $shift = WORK_TIME;
        for my $cmd (@$commandsToWork)
        {
            qx {$cmd};    
        }
    } else {
        $shift = BREAK_TIME;
        for my $cmd (@$commandsToBreak)
        {
            qx {$cmd};    
        }
    }
    $isWorking = 1 - $isWorking;
    my $now = time;
    my $endtime = $now + $shift;
    sleep $endtime - $now
}

