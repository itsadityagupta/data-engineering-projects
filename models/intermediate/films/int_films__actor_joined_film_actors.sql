with film_actors as (

    select * from {{ ref('stg_db__film_actors') }}

),
actor_details as (

    select * from {{ ref('stg_db__actors') }}

)
select
fa.film_id,
array_agg(ad.name) as actor_names
from film_actors fa left join actor_details ad on fa.actor_id = ad.actor_id
group by fa.film_id
order by fa.film_id
