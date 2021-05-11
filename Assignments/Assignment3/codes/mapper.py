'''The mapper generates a series of key-value pairs based on the input data.
   This example is a word count MapReduce program. Therefore, this program splits
   the input file line by line, and does the mapping
   The output of this is passed to the reducer program as input.'''
   
   
import sys

#the standard input comes from the output of the cat command
for line in sys.stdin:
	#to get rid of unnecessary leading and trailing whitespaces
	line=line.strip()
	
	#split at the whitespaces to get the words in a list
	words=line.split()
	
	#now, for each instance of each word, have to output the word along with its count, and since we're doing this for each instance, trivial count will be 1 for all
	#this is what we're passing to the reducer program
	for word in words:
		print(word,1,sep="\t")
