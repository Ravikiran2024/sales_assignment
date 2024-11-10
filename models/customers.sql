{{ config(
    materialized='table',
    alias='customers_model'
) }}

with customers as (
    select 
        id as customer_id,
        first_name,
        last_name
    from {{ source('PC_HEVODATA_DB','customers') }}
),

orders as (
    select 
        user_id as customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(id) as number_of_orders
    from {{ source('PC_HEVODATA_DB','orders') }}
    group by customer_id
),

payments as (
    select 
        orders.user_id as customer_id,
        sum(payments.amount) as customer_lifetime_value
    from {{ source('PC_HEVODATA_DB','payments') }} as payments
    join {{ source('PC_HEVODATA_DB','orders') }} as orders
    on payments.order_id = orders.id
    group by customer_id
)

select 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.first_order,
    o.most_recent_order,
    o.number_of_orders,
    p.customer_lifetime_value
from customers c
left join orders o on c.customer_id = o.customer_id
left join payments p on c.customer_id = p.customer_id
