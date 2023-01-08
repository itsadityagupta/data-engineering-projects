with source as (

    select * from {{ source('dvdrental', 'actors') }}

),

renamed as (

    select
        actor_id,
        concat(first_name, ' ', last_name) as name,
        last_update as last_updated

    from source

)

select * from renamed