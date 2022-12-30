with churned_per_city as (
    select city, count(*) as no_of_customers
    from {{ ref("stg_churn__customer_details") }}
    where customer_status = 'Churned'
    group by city
    order by city
)
select * from churned_per_city