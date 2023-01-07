with source as (

    select * from {{ source('dvdrental', 'countries') }}

),

renamed as (

    select
        country_id,
        country,
        last_update as last_updated

    from source

)

select * from renamed
