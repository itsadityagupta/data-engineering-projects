with final as (
    select * from {{ source('churn', 'customer_details') }}
)
select * from final