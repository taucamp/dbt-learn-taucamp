{{
  config(
    materialized='table'
  )
}}


with customers as (
    select * 
    from  {{ ref('stg_customers') }}
),


customer_orders as (
    select customer_id,
      min(order_date) as first_order_date,
      max(order_date) as most_recent_order_date,
      count(order_id) as number_of_orders,
      sum(order_total) as customer_lifetime_order_amount
      
    from {{ ref('fct_orders') }}
    
    group by 1
),


final as (
    select
        customers.customer_id,
        -- customers.first_name,
        -- customers.last_name,
        customers.customer_name,
        first_order_date,
        most_recent_order_date,
        coalesce(number_of_orders,0) as number_of_orders,
        coalesce(customer_lifetime_order_amount,0) as lifetime_order_amount
        
    from customers
    left join customer_orders using (customer_id)
)
select * from final