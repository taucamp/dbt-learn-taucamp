{{
  config(
    materialized='table'
  )
}}


with customers as (
    select * 
    from  {{ ref('stg_customers') }}
),


customer_orders AS (
    SELECT customer_id,
      MIN(order_date) AS first_order_date,
      MAX(order_date) AS most_recent_order_date,
      COUNT(order_id) AS number_of_orders,
      SUM(order_total) AS customer_lifetime_order_amount
      
    FROM {{ ref('fct_orders') }}
    
    GROUP BY 1
),


final AS (
    SELECT
        customers.customer_id,
        -- customers.first_name,
        -- customers.last_name,
        customers.customer_name,
        first_order_date,
        most_recent_order_date,
        coalesce(number_of_orders,0) AS number_of_orders,
        coalesce(customer_lifetime_order_amount,0) AS lifetime_order_amount
        
    FROM customers
    LEFT JOIN customer_orders USING (customer_id)
)
SELECT * FROM final