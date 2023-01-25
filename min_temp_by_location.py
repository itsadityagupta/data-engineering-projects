from mrjob.job import MRJob


def to_fahrenheit(tenth_of_celsius):
    celsius = float(tenth_of_celsius) / 10.0
    fahrenheit = (celsius * 1.8) + 32.0
    return fahrenheit


class MinTempByLocation(MRJob):

    def mapper(self, key, line):
        (location, _, temp_type, temp) = line.split(',')[:4]
        if temp_type == 'TMIN':
            yield location, to_fahrenheit(temp)

    def reducer(self, location, temperatures):
        yield location, min(temperatures)


if __name__ == '__main__':
    MinTempByLocation.run()
