with source as (

    select * from {{ source('dvdrental', 'films') }}

),

renamed as (

    select
        film_id,
        title,
        description,
        release_year,
        language_id,
        rental_duration,
        rental_rate,
        length,
        replacement_cost,
        rating,
        last_update as last_updated,
        special_features,
        fulltext

    from source

)

select * from renamed