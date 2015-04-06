#!/usr/bin/perl
use strict;
use warnings;

sub GetSequence ()
{
	my $Realanch1="";
	my $Realanch2="";
	my $anch1=$_[0];
	my $anch2=[1];
	my $source=$_[2];

	my $len_source  = length $source;
	my $len_anch = length $anch1;
	
	for my $i ( 0 .. $len_source - $len_anch ) 
	{
		my $Teststring = substr $source, $i, $len_anch;
		if (FindSeq( $anch1, $Teststring, 2) && $Realanch1 eq "")
		{
			$Realanch1=$Teststring;
		}
		
		if (FindSeq( $anch2, $Teststring, 2)&& $Realanch2 eq "" )
		{
			$Realanch2=$Teststring;
			
		}
		
		if($Realanch1 ne"" && $Realanch2 ne "")
		{
			
			last;
		}
	}

	   my $sequence="";
	   
	   if($source =~ /$Realanch1(.*)$Realanch2/) #Finding string between anchors
	   {
	    ($sequence)= $source =~ /$Realanch1(.*)$Realanch2/; 

	   }
	   elsif($source =~ /$Realanch2(.*)$Realanch1/)
	   {
	    	    ($sequence)= $source =~ /$Realanch2(.*)$Realanch1/; 
	   }
	   print "$Realanch1\n"; 
	   print "$Realanch2\n"; 


	return $sequence;
}

sub FindSeq {
    my ( $anchor, $sequence, $diffAllow ) = @_;
    my $Actualldif = () = ( $anchor ^ $sequence ) =~ /[^\x00]/g; #Finding amount of differances between the 2 strings
	#print "$Actualldif\n"; 
    return $Actualldif <= $diffAllow; # Retuerns if the differance is <= than allowed differance
}
