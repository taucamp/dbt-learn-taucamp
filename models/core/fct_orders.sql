{{
  config(
    materialized='view'
  )
}}

WITH 

orders as (
    SELECT * FROM {{ ref('stg_orders') }}
)
, 
order_payments AS (
    SELECT 
    order_id,
    sum(order_amount) as order_total
     FROM {{ ref('stg_payments') }}
     group by 1
)

SELECT 
orders.order_id,
orders.customer_id,
orders.order_date,
orders.order_status,
coalesce(order_payments.order_total,0) as order_total

FROM orders 
    LEFT JOIN order_payments USING (order_id)
