with source as (

    select * from {{ source('dvdrental', 'stores') }}

),

renamed as (

    select
        store_id,
        manager_staff_id,
        address_id,
        last_update as last_updated

    from source

)

select * from renamed
