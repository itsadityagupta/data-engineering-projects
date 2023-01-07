with source as (

    select * from {{ source('dvdrental', 'rentals') }}

),

renamed as (

    select
        rental_id,
        rental_date,
        inventory_id,
        customer_id,
        return_date,
        staff_id,
        last_update as last_updated

    from source

)

select * from renamed
