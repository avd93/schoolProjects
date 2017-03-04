######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  Angelica Davis			
#  angelica.davis@msu.montana.edu			
#										
#########################################

# Replace the string value of the following variable with your names.
my $name = "Angelica Davis";
my $partner = "<Replace with your partner's name>";
print "CSCI 305 Lab 1 submitted by $name.\n\n";

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";


# YOUR VARIABLE DEFINITIONS HERE...
my $title = "Fail String\n";
my @words = ();
my %bigram = ();

# This loops through each line of the file
while($line = <INFILE>) {
	#match each song title to the string after three <SEP>'s and before a new line	
	if ($line =~ m/<SEP>.+<SEP>.+<SEP>(.+)\n/){
		$title = "$1";
	
		#replace text after (,[,{,\,/,_,-,:,",`,+,=,*,feat. with nothing
		# each on a line for readability
		$title =~ s/\(.+//;
		$title =~ s/\[.+//;
		$title =~ s/\{.+//;
		$title =~ s/\\.+//;
		$title =~ s/\/.+//;
		$title =~ s/_.+//;
		$title =~ s/\-.+//;
		$title =~ s/:.+//;
		$title =~ s/\".+//;
		$title =~ s/`.+//;
		#$title =~ s/'.+//;
		$title =~ s/\+.+//;
		$title =~ s/=.+//;
		$title =~ s/\*.+//;
		$title =~ s/feat\.\..+//;
	
		#remove punctuation: ?,¿,!,¡,.,;,&,$,@,%,#,|
		$title =~ s/\?//g;
		$title =~ s/¿//g;
		$title =~ s/!//g;
		$title =~ s/¡//g;
		$title =~ s/\.//g;
		$title =~ s/;//g;
		$title =~ s/&//g;
		$title =~ s/\$//g;
		$title =~ s/\@//g;
		$title =~ s/%//g;
		$title =~ s/#//g;
		$title =~ s/\|//g;


		#filter out titles with non-English characters
		if ($title !~ m/[^[:ascii:]]/g){
	
			#convert all song titles to lowercase
			$title =~ tr/A-Z/a-z/;
		
			#remove stop words: a an and by for from in of on or out the to with
			# replaces stop words with spaces to maintain spacing in each title
			$title =~ s/\s?a\s/ /g;
			$title =~ s/\s?an\s/ /g;
			$title =~ s/\s?and\s/ /g;
			$title =~ s/\s?by\s/ /g;
			$title =~ s/\s?for\s/ /g;
			$title =~ s/\s?from\s/ /g;
			$title =~ s/\s?in\s/ /g;
			$title =~ s/\s?of\s/ /g;
			$title =~ s/\s?on\s/ /g;
			$title =~ s/\s?or\s/ /g;
			$title =~ s/\s?out\s/ /g;
			$title =~ s/\s?the\s/ /g;
			$title =~ s/\s?to\s/ /g;
			$title =~ s/\s?with\s/ /g;
		

			#isolate each word in a title and store bi-grams in a hash of hashes
			# and include a count of the number of times each bi-gram occurs in a title
			@words = split(/ /, $title);
			for (my $i = 0; $i < $#words; $i++){
				#check for keys already entered to avoid double counting
				# then set subsequent adjacent array value as each subsequent hash's key respectively
				if (exists $bigram{$words[$i]}){
					if (exists $bigram{$words[$i]}{$words[$i+1]}){
						$bigram{$words[$i]}{$words[$i + 1]} += 1;
					} else{
						$bigram{$words[$i]}{$words[$i + 1]} = 1;
					}
				} else{
					$bigram{$words[$i]}{$words[$i + 1]} = 1;
				}
			}	
	
		}
		
	}	

}  #end of while loop


# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print "File parsed. Bigram model built.\n\n";


# User control loop
my $input;
while ($input ne "q"){
	print "Enter a word [Enter 'q' to quit]: ";
	$input = <STDIN>;
	chomp($input);
	print "\n";	
	# Replace these lines with some useful code
	#print "Not yet implemented.  Goodbye.\n";
	
	if ($input eq "q"){
		print "Goodbye.\n";
	} else{
		probableTitle($input);
		#my $outPut = mcw($input);
		#print "\n$outPut\n\n";
	}

}

# MORE OF YOUR CODE HERE....

#function mcw returns the most common word to follow wordIn
sub mcw {
	my ($wordIn) = @_;
	my $count = 0;
	my $mostCommon;
	
	#checks the number of times each word following wordIn occurs
	for my $k2 (keys %bigram->{$wordIn}){
		#count stores the greatest number of a word's occurrence after wordIn
		# and $k2 holds the word acting as the key of the greatest number of occurrences
		if($count < $bigram{$wordIn}{$k2}){
			$count = $bigram{$wordIn}{$k2};
			$mostCommon = $k2;
		}
	}
		#tie breaker decides which word is returned based on random values
		if($count == $bigram{$wordIn}{$k2}){
			$rand1 = rand();
			$rand2 = rand();
			
			#choice goes to current key if rand2 is bigger
			# and stays with $mostCommon otherwise
			if($rand1 <= $rand2){
				$count = $bigram{$wordIn}{$k2};
				$mostCommon = $k2;
			}
		}
	return $mostCommon;
}
	
#function creates a title of at most 20 likely words
sub probableTitle {
	my ($startWord) = @_;
	my @title = ();
	push(@title, $startWord);
	my $i = 0; 
	
	#while loop quits if the title isn't less than 20 words 
	# and if it doesn't have a subsequent word
	while ($i < 20 && exists $bigram{$startWord}){	
		print "$title[$i] ";
		$startWord = mcw($startWord);
		$i++;
		push(@title, $startWord);
	}
	print "\n\n";
}