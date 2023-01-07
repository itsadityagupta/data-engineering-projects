with films as (

    select * from {{ ref('int_films__joined_language') }}

),
film_categories as (

    select * from {{ ref('stg_db__film_categories') }}

),
category_details as (

    select * from {{ ref('stg_db__categories') }}

)

select
f.film_id,
f.title,
f.description,
f.release_year,
f.language,
cd.name as category,
f.rental_duration,
f.rental_rate,
f.length,
f.replacement_cost,
f.rating,
f.special_features,
f.fulltext,
f.last_updated
from films f left join film_categories fc on f.film_id = fc.film_id
left join category_details cd on fc.category_id = cd.category_id
