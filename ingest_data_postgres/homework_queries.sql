-- Question 3. Count records
select count(*) as total_trips
from yellow_taxi_trips yt
where yt.lpep_pickup_datetime::date >= '2019-01-15'
and yt.lpep_dropoff_datetime::date <= '2019-01-15'

--ans: 20530

-- Question 4. Largest trip for each day
select yt.lpep_pickup_datetime::date as day,
max(yt.trip_distance) as max_trip_distance
from yellow_taxi_trips yt
group by yt.lpep_pickup_datetime::date
order by max(yt.trip_distance) desc

--ans: 2019-01-15

-- Question 5. The number of passengers
select yt.passenger_count, count(1)
from yellow_taxi_trips yt
where yt.lpep_pickup_datetime::date = '2019-01-01'
and yt.passenger_count in (2, 3)
group by yt.passenger_count

/* ans:
"passenger_count"	"total_trips"
2	                   1282
3	                   254
*/

-- Question 6. Largest tip
with trip_zone as (
	select yt.* , dz."Zone" drop_zone, pz."Zone" pick_up_zone
	from yellow_taxi_trips yt
	inner join zones dz on yt."DOLocationID" = dz."LocationID"
	inner join zones pz on yt."PULocationID" = pz."LocationID"
)
select drop_zone from trip_zone tz
where tz."pick_up_zone" = 'Astoria'
order by tip_amount desc
limit 1

-- ans: "Long Island City/Queens Plaza"
