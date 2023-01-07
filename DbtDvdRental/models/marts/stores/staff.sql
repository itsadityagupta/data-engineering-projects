with staff as (

    select * from {{ ref('stg_db__staff') }}

)
select * from staff
