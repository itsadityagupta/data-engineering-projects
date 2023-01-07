with source as (

    select * from {{ source('dvdrental', 'staff') }}

),

renamed as (

    select
        staff_id,
        first_name,
        last_name,
        address_id,
        email,
        store_id,
        active,
        username,
        password,
        last_update as last_updated,
        picture

    from source

)

select * from renamed
