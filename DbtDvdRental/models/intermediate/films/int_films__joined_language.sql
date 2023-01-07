with films as (

    select * from {{ ref('stg_db__films') }}

),
language_details as (

    select * from {{ ref('stg_db__languages') }}

)

select
f.film_id,
f.title,
f.description,
f.release_year,
ld.name as language,
f.rental_duration,
f.rental_rate,
f.length,
f.replacement_cost,
f.rating,
f.special_features,
f.fulltext,
f.last_updated
from films f left join language_details ld on f.language_id = ld.language_id
