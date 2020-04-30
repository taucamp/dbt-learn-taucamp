SELECT
    id AS order_id,
    user_id AS customer_id,
    order_date,
    status AS order_status

FROM {{ source('jaffle_shop', 'orders') }}
-- FROM raw.jaffle_shop.orders
