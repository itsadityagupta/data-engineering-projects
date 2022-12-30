from mrjob.job import MRJob


class AverageFriendsByAge(MRJob):

    def mapper(self, key, line):
        (user_id, name, age, number_of_friends) = line.split(",")
        yield age, float(number_of_friends)

    def reducer(self, age, number_of_friends):
        total_friends = 0
        count = 0
        for friends in number_of_friends:
            total_friends += friends
            count += 1
        yield age, total_friends/count

if __name__ == '__main__':
    AverageFriendsByAge.run()
