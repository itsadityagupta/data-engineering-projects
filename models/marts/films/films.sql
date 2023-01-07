with films as (

    select * from {{ ref('int_films__joined_actor') }}

)
select * from films