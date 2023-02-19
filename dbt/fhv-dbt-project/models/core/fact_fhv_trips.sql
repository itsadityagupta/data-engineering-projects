with
    dim_zones as (select * from {{ ref("dim_zones") }} where borough != 'Unknown'),
    fhv as (select * from {{ ref("stg_fhv_tripdata") }})
select
    dispatching_base_num,
    pickup_datetime,
    dropoff_datetime,
    pickup_locationid,
    pickup_zone.borough as pickup_borough,
    pickup_zone.zone as pickup_zone,
    dropoff_locationid,
    dropoff_zone.borough as dropoff_borough,
    dropoff_zone.zone as dropoff_zone,
    sr_flag,
    affiliated_base_number
from fhv
inner join dim_zones as pickup_zone on fhv.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone on fhv.dropoff_locationid = dropoff_zone.locationid
