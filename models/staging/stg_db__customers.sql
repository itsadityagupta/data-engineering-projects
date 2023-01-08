with source as (

    select * from {{ source('dvdrental', 'customers') }}

),

renamed as (

    select
        customer_id,
        store_id,
        concat(first_name, ' ', last_name) as name,
        email,
        address_id,
        activebool,
        create_date,
        last_update as last_updated,
        active

    from source

)

select * from renamed