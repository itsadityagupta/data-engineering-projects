with source as (

    select * from {{ source('dvdrental', 'film_categories') }}

),

renamed as (

    select
        film_id,
        category_id,
        last_update as last_updated

    from source

)

select * from renamed