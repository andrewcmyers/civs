#!/usr/bin/perl

use strict;
use warnings;

use lib '/cucs/web/w8/andru/public_html/cgi-perl/civs';
# use admctrl;
use civs_common;

use CGI qw(:standard);
use File::stat;
use DB_File;
undef $/;

&HTML_Header("CIVS Election deletion");
use election;
&CIVS_Header("Election deletion");

CheckElectionID;

if (param('key') ne '@ADMIN_KEY@') {
    print p("Password missing or wrong");
    exit 1;
}

system("/bin/rm -r '$home/elections/$election_id'");

print p("Election $election_id deleted");
Log "Election $election_id deleted";

print end_html();


