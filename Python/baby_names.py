"""
Zachary Goss baby_names.py
Code taken from
https://mrjob.readthedocs.io/en/stable/guides/quickstart.html#writing-your-second-job,
last access 11/27/2017
As well as Dr. V's MrMostUsedWord.py program last accessed 12/7/2017

The line split on line 34 was modified from:
https://www.quora.com/What-are-the-steps-that-I-need-to-follow-to-read-a-column-from-a-CSV-file-in-Python-MRjob-Map-reduce-program
last accessed 12/6/2017
"""
#edit configurations under script parameters after space enter file name for source document
#terminal mrjob create-cluster --conf-path=mrjob.conf to send to cloud
#to output to text file enter in terminal python sorted_anagrams.py -r emr --conf-path=mrjob.conf inputfile.txt > outputfile.txt

from mrjob.job import MRJob
from mrjob.step import MRStep
import re

WORD_RE = re.compile(r"[\w']+")

class BabyNameSorter(MRJob):

    def steps(self):
        return [
            MRStep(mapper=self.mapper_sort_names,
                   combiner=self.combiner_count_names,
                   reducer=self.reducer_count_names),
            MRStep(reducer=self.reducer_find_max_names)
        ]

    def mapper_sort_names(self, _, line):
        # yield each word in the line
        (state, sex, year, name, count) = line.split(',')
        counts = int(count)
        sex = ', ' + sex
        #name = ''.join((name, sex))
        for name in WORD_RE.findall(name):
            yield (name + sex, counts)

    def combiner_count_names(self, word, counts):
        # optimization: sum the words we've seen so far
        yield (word, sum(counts))

    def reducer_count_names(self, word, counts):
        # send all (num_occurrences, word) pairs to the same reducer.
        # num_occurrences is so we can easily use Python's max() function.
        yield None, (sum(counts), word)

    # discard the key; it is just None
    def reducer_find_max_names(self, sex, word_count_pairs):
        # each item of word_count_pairs is (count, word),
        # so yielding one results in key=counts, value=word

        # yield max(word_count_pairs)
        MRJob.SORT_VALUES = None
        for wc in sorted(word_count_pairs, reverse=True):
            yield wc
            #yield sex



if __name__ == '__main__':
    BabyNameSorter.run()