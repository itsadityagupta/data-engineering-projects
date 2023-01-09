with films as (

    select * from {{ ref('int_films__joined_category') }}

),
film_actors as (

    select * from {{ ref('int_films__actor_joined_film_actors') }}

)
select
f.film_id,
f.title,
f.description,
f.release_year,
f.language,
f.category,
fa.actor_names,
f.rental_duration,
f.rental_rate,
f.length,
f.replacement_cost,
f.rating,
f.special_features,
f.fulltext,
f.last_updated
from films f left join film_actors fa on f.film_id = fa.film_id
