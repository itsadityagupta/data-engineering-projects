with stores as (

    select * from {{ ref('int_stores__stores_joined_staff') }}

)
select *
from stores
where manager_store_id != store_id