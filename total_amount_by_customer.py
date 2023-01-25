from mrjob.job import MRJob
from mrjob.step import MRStep


class TotalAmountbyCustomer(MRJob):

    def steps(self):
        return [
            MRStep(mapper=self.mapper_get_amounts, reducer=self.reducer_order_total),
            MRStep(mapper=self.mapper_amount_as_key, reducer=self.reducer_customer_as_key)
            # to get results in sorted order
        ]

    def mapper_get_amounts(self, key, line):
        (customer, item, order_amount) = line.split(',')
        yield customer, float(order_amount)

    def reducer_order_total(self, customer, amounts):
        yield customer, sum(amounts)

    def mapper_amount_as_key(self, customer, total_amount):
        yield '%04.02f' % float(total_amount), customer

    def reducer_customer_as_key(self, amount, customers):
        for customer in customers:
            yield customer, amount


if __name__ == '__main__':
    TotalAmountbyCustomer.run()
