############################################################## 	
#  A helper perl script to select a subset of lines  
#  from a large text file	
#
#  To run: 
#   perl selectFromText.pl filePath/largeFile.txt
#
#  Summary:
#  The process is simply to partition the original text file
#  given the number of lines in the original file and the number 
#  of lines to be in the new file, and make a single line
#  extraction for every partitioned interval.
#
#  More Details:
#  A partition is defined as: origFileNumLines/newFileNumLines
#   rounded down to the nearest 10
#  A line is extracted when lineNumber mod partition = 0	
#										
#  Angelica Davis			
#  an.v.davis@gmail.com			
#										
##############################################################
use POSIX;

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";

# prompt user for max lines to pull from the given text file
print "Enter the maximum number of lines to select from the text file> ";
my $cap = <STDIN>;
print "Enter the number of lines in the text file> ";
my $numLines = <STDIN>;
print "Processing file...\n";

my $counter = 0;
my $partition = definePartition($cap, $numLines);
my @fileSelection = ();
# Loop file to roughly sample along the partition defined
while($line = <INFILE>) {
	if($counter % $partition == 0){ 
		push(@fileSelection, $line);
	}
	$counter ++;
} 
# Close the file handler
close INFILE;

# Transfer the selected lines to a given output file
print "Enter the output file path, e.g. filepath/outfile.txt> ";
my $outfile = <STDIN>;
# Remove trailing newline from file name
chomp($outfile); 
# Create new output file
open (my $fh, '>', $outfile) or die "Could not create file '$outfile' $!";
	foreach my $line (@fileSelection){
		print $fh "$line";
	}
close $fh;

# subroutine defines a partition as numLines/cap rounded down to the nearest 10
# $numLines - the number of lines in a text file
# $cap - the user defined max number of lines to pull from the text file
sub definePartition{
	my ($cap,$numLines) = (@_);
	return floor($numLines/($cap*10))*10;
}