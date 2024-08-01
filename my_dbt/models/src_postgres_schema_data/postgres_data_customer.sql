with source_customer as (
    select * from {{ source('customer', 'jaffle_shop_customers')}}
),


final as (
    select * from source_customer
)

select * from final