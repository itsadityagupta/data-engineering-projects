with payments as (

    select * from {{ ref('stg_db__payments') }}

),
rentals as (

    select * from {{ ref('int_finance__rentals_joined_inventory') }}

)
select
p.payment_id,
p.customer_id as payment_customer_id,
p.staff_id as payment_staff_id,
r.rental_date,
r.film_id,
r.store_id,
r.customer_id as rental_customer_id,
r.return_date,
r.staff_id as rental_staff_id,
p.amount,
p.payment_date
from payments p left join rentals r on p.rental_id = r.rental_id
