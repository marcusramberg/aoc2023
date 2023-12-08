#!/usr/bin/perl
use strict;
my $sum=0;
while (my $round = <>) {
  my ($game, $games) = split /:/, $round;
  my ($id) = $game =~ /(\d+)$/;
  my $toobig=0;
  print $games;
  my %seen;
  foreach my $game (split /;/, $games) {
    my ($red) = $game =~ /(\d+) red/;
    $seen{red} = $red if $red>$seen{red};
    my ($blue) = $game =~ /(\d+) blue/;
    $seen{blue} = $blue if $blue>$seen{blue};
    my ($green) = $game =~ /(\d+) green/;
    $seen{green} = $green if $green>$seen{green};
  }
  my $power=$seen{green}*$seen{red}*$seen{blue};
  $sum += $power;
}
print $sum;
