with rentals as (

    select * from {{ ref('stg_db__rentals') }}

),
inventory as (

    select * from {{ ref('stg_db__inventory') }}

)
select
r.rental_id,
r.rental_date,
i.film_id,
i.store_id,
r.customer_id,
r.return_date,
r.staff_id,
r.last_updated
from rentals r left join inventory i on r.inventory_id = i.inventory_id
