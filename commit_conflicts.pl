#!/usr/bin/perl -w
use strict;

my $status = 'already added';

while (<>)
{
	next unless $status eq 'unmerged' || (/^Unmerged/);
	if (/^Unmerged/)
	{
		$status = 'unmerged';
		next;
	}

	next unless (/^\t[^:]+:\s+/);

	if ((/^\tboth (added|modified):\s+(.+)$/) || (/^\tadded by (us):\s+(.+)$/))
	{
		print "#" . $_ . "git add " . $2 . "\n";
	}
	elsif (/^\tdeleted by (us|them):\s+(.+)$/)
	{
		print "#" . $_ . "git rm -f " . $2 . "\n";
	}
	elsif (/^\tadded by them:\s+(.+)$/)
	{
		my $new_file = $1;
		if ($new_file !~ /^doc\//)
		{
			print "#" . $_ . "git add " . $new_file ."\n";
		}
		else
		{
			print "# Skipped: " . $_;
		}
	}
	else
	{
		print "# Skipped: " . $_;
	}
}
