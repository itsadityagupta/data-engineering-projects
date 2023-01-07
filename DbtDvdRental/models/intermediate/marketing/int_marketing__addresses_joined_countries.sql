with addresses as (

    select * from {{ ref('int_marketing__addresses_joined_cities') }}

),
countries as (

    select * from {{ ref('stg_db__countries') }}

)
select
a.address_id,
a.address,
a.address2,
a.city,
c.country,
a.postal_code,
a.phone,
a.last_updated
from addresses a left join countries c on a.country_id = c.country_id
