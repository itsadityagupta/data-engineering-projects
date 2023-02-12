-- create external table and load the fhv 2019 data

CREATE OR REPLACE EXTERNAL TABLE `week4.external_table`
OPTIONS (
  format= 'CSV',
  uris = ['gs://dezoomcampweek4adi/fhv_tripdata_2019-*']
);

-- create BQ table

CREATE OR REPLACE TABLE `week4.internal_table` AS
SELECT * FROM `week4.external_table`;

-- question 1

select count(1) from week4.external_table;

-- ans: 432446969

-- question 2

select count(distinct Affiliated_base_number) from week4.external_table;

select count(distinct Affiliated_base_number) from week4.internal_table;

-- ans: 0 MB for the External Table and 317.94MB for the BQ Table

-- question 3

select count(1) from week4.internal_table
where PUlocationID is NULL and DOlocationID is NULL;

-- ans: 717748

-- question 4

-- ans: Partition by pickup_datetime Cluster on affiliated_base_number

-- question 5

CREATE OR REPLACE TABLE week4.optimized_table 
PARTITION BY DATE(pickup_datetime)
CLUSTER BY Affiliated_base_number
AS SELECT * FROM week4.internal_table

select distinct Affiliated_base_number from week4.internal_table
where DATE(pickup_datetime) >= '2019-03-01' and DATE(pickup_datetime) <= '2019-03-31'

select distinct Affiliated_base_number from week4.optimized_table
where DATE(pickup_datetime) >= '2019-03-01' and DATE(pickup_datetime) <= '2019-03-31'

-- ans: 647.87 MB for non-partitioned table and 23.06 MB for the partitioned table

-- Question 6

-- ans: GCP Bucket

-- Question 7

-- ans: False
