SELECT
        id AS customer_id,
        first_name,
        last_name,
        concat(first_name,' ',last_name) as customer_name
    FROM raw.jaffle_shop.customers