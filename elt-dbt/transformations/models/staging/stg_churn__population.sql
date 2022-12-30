with final as (
    select * from {{ source('churn', 'population') }}
)
select * from final