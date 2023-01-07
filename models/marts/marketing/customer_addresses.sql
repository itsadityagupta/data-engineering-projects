with addresses as (

    select * from {{ ref('int_marketing__addresses_joined_countries') }}

),
stores as (

    select * from {{ ref('stg_db__stores') }}

)
select *
from addresses
where addresses.address_id not in (select stores.address_id from stores)
