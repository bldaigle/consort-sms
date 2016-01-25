#!/usr/bin/perl

print "Content-type:text/html\n\n";
use Mail::Sendmail;
use strict;
use CGI;
my $from = 'tripod@trilogy.brynmawr.edu';

#print STDERR $ENV{'QUERY_STRING'}."\n";
my %providrs = ('cingular' => '@cingularme.com',
                'tmobile' => '@tmomail.net',
                'virgin' => '@vmobl.com',
                'sprint' => '@messaging.sprintpcs.com',
                'nextel' => '@messaging.nextel.com',
                'verizon'=> '@vtext.com');


my $q = new CGI;
my $num = $q->param('number');
   $num =~ s/[^\d]//ig;
my $to = $num.$providrs{$q->param('provider')};
$to =~ s/[\(\)\-\s]//ig;
my $loc  = $q->param('item');
my $subject = "tripod result";
my $title = $q->param('title');
my $body = "$loc\ntitle:$title";
my %mail = (
         from => $from,
         to => $to,
         subject => $subject,
         body => $body
        );

sendmail(%mail) || print "Error: $Mail::Sendmail::error \n";

print "alert('sent!');";
print "clearsms()";