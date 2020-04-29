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
      sum(order_amount) as customer_lifetime_order_amount
      
    from {{ ref('fct_orders') }}
    
),


final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers.customer_name,
        first_order_date,
        most_recent_order_date,
        number_of_orders
        customer_lifetime_order_amount
    from customers
    left join customer_orders using (customer_id)
)
select * from final