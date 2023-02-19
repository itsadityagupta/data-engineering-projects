-- question 1

SELECT count(*)
 FROM `dtc-de-zoomcamp-2023.dbt_aditya_gupta.fact_trips`
 where DATE(pickup_datetime) >= DATE(2019, 01, 01) and DATE(pickup_datetime) <= DATE(2020, 12, 31);

 -- ans: 61640312

-- question 3

select count(*)
from dbt_aditya_gupta.stg_fhv_tripdata
where extract(year from pickup_datetime) = 2019

-- ans: 43244696

-- question 4

select count(*)
from dbt_aditya_gupta.fact_fhv_trips
where extract(year from pickup_datetime) = 2019

-- ans: 22998722

