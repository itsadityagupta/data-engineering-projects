with stores as (

    select * from {{ ref('stg_db__stores') }}

),
staff as (

    select * from {{ ref('stg_db__staff') }}

)

select
stores.store_id,
stores.manager_staff_id,
staff.name as manager_name,
staff.address_id as manager_address_id,
staff.email as manager_email,
staff.store_id as manager_store_id, -- this should be same as stores.store_id
stores.address_id as store_address_id,
staff.last_updated as manager_last_updated,
stores.last_updated
from stores left join staff on stores.manager_staff_id = staff.staff_id
