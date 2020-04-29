SELECT
        id AS customer_id,
        first_name,
        last_name,
        CONCAT(first_name,' ',last_name) AS customer_name
    FROM raw.jaffle_shop.customers