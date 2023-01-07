with addresses as (

    select * from {{ ref('stg_db__addresses') }}

),
cities as (

    select * from {{ ref('stg_db__cities') }}

)
select
a.address_id,
a.address,
a.address2,
a.district,
c.city,
c.country_id,
a.postal_code,
a.phone,
a.last_updated
from addresses a left join cities c on a.city_id = c.city_id
