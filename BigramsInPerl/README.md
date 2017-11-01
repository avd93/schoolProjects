# Bi-grams in Perl
## Assignment Summary
>Use regular expressions in Perl to extract song titles from a file containing one million
song titles plus meta-data (a data set provided by Laboratory for the Recognition
and Organization of Speech and Audio at Columbia University). Next use a hash of hashes table to construct a collection of bi-grams and count how often each bi-gram occurs in all song titles. Stop words are removed (e.g. a, an, and, by, for, from, in, of, on, or, out, the, to, with, feat.) as well as words containing non-English characters.

## Using the Script
>The script allows a user to enter a word and see the most probable song title to follow the word entered, up to 20 words per probable title. 

>To run: perl wordBigrams.pl filepath/inputFile.txt

>Test files included in this repo are a_tracks.txt- only track names beginning with 'a'- and unique_tracks_selected.txt- a sampling of 1000 song titles from the original data set.

## Valuable Concepts Learned through this Exercise
* How to use regular expressions to efficiently sift through large datasets.
* A great example of an effective application of a hash table to drive a solution.
* Regular expression syntax and understanding of Perl's functions for effective implementation and debugging.
* Construction and manipulation of hashes in Perl, in particular referencing keys and values in a hash table of hashes.

