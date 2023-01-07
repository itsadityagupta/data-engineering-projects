with source as (

    select * from {{ source('dvdrental', 'inventory') }}

),

renamed as (

    select
        inventory_id,
        film_id,
        store_id,
        last_update as last_updated

    from source

)

select * from renamed