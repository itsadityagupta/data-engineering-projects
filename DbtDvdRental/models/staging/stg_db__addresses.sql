with source as (

    select * from {{ source('dvdrental', 'addresses') }}

),

renamed as (

    select
        address_id,
        address,
        address2,
        district,
        city_id,
        postal_code,
        phone,
        last_update as last_updated

    from source

)

select * from renamed
