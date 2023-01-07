with payments as (

    select * from {{ ref('int_finance__payments_joined_rentals') }}

)
select * from payments
