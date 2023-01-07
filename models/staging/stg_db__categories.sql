with source as (

    select * from {{ source('dvdrental', 'categories') }}

),

renamed as (

    select
        category_id,
        name,
        last_update as last_updated

    from source

)

select * from renamed
