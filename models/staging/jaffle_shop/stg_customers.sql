SELECT
        id AS customer_id,
        first_name,
        last_name,
        CONCAT(first_name,' ',last_name) AS customer_name
    
    FROM {{ source('jaffle_shop', 'customers') }}
    -- FROM raw.jaffle_shop.customers