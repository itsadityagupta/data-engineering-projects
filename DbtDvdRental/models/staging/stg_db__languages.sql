with source as (

    select * from {{ source('dvdrental', 'languages') }}

),

renamed as (

    select
        language_id,
        name,
        last_update as last_updated

    from source

)

select * from renamed