with customers as (

    select * from {{ ref('stg_db__customers') }}

)
select * from customers
