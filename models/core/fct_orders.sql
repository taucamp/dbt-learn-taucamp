{{
  config(
    materialized='view'
  )
}}

WITH 

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)
, 
order_payments AS (
    SELECT 
    order_id,
    sum(order_amount) AS order_total
     FROM {{ ref('stg_payments') }}
     GROUP BY 1
)

SELECT 
  orders.order_id,
  orders.customer_id,
  orders.order_date,
  orders.order_status,
  COALESCE(order_payments.order_total,0) AS order_total

FROM orders 
    LEFT JOIN order_payments USING (order_id)
