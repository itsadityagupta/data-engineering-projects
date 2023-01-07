with source as (

    select * from {{ source('dvdrental', 'film_actors') }}

),

renamed as (

    select
        actor_id,
        film_id,
        last_update as last_updated

    from source

)

select * from renamed