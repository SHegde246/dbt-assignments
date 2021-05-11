'''The reducer combines all values that are associated with equivalent keys.'''

import sys

#we need this variable to know when to switch to the next word in the sorted order, ie, after all the instances of a word have been exhausted
current_word=None
current_count=0

#Hadoop does the shuffling step after the mapping. This shuffled order is given to the reducer (shuffled based on key, ie, the word)
#can be simulated in terminal ((sort -k1,1), ie sort based on forst column)
for line in sys.stdin:
	line=line.strip()
	
	word,count=line.split("\t")
	count=int(count)
	
	#keep increasing the count so long as it's the same word
	if word==current_word:
		current_count+=count
	else:
		#during the first pass, current_word will still be None. Therefore, we print the output only if current_word is not None.
		#in the first pass, this is if is skipped, and current_word gets updated to the first word
		if current_word:
		
			#output the current word with its count
			print(current_word,current_count,sep="\t")
	
		#we have to update the current word to the next word in the shuffled order
		current_word=word
		current_count=count

#for the last word-
if word==current_word:
	print(current_word,current_count,sep="\t")


	
