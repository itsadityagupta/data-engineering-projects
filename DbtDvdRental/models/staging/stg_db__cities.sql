with source as (

    select * from {{ source('dvdrental', 'cities') }}

),

renamed as (

    select
        city_id,
        city,
        country_id,
        last_update as last_updated

    from source

)

select * from renamed
