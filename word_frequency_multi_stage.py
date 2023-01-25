from mrjob.job import MRJob
from mrjob.step import MRStep
import re

WORD_REGEX = re.compile(r"[\w']+")


class WordFrequencyMultiStageChaining(MRJob):

    def steps(self):
        """Multi Step MapReduce jobs to properly sort the words."""
        return [
            MRStep(mapper=self.mapper_get_words, reducer=self.reducer_count_words),
            MRStep(mapper=self.mapper_make_counts_key, reducer=self.reducer_output_words)
        ]

    def mapper_get_words(self, _, line):
        words = WORD_REGEX.findall(line)
        for word in words:
            yield word.lower(), 1

    def reducer_count_words(self, word, frequency):
        yield word, sum(frequency)

    def mapper_make_counts_key(self, word, count):
        yield '%04d'%int(count), word

    def reducer_output_words(self, count, words):
        for word in words:
            yield count, word


if __name__ == '__main__':
    WordFrequencyMultiStageChaining.run()
