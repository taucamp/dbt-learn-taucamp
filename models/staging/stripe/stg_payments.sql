SELECT
     "orderID" AS order_id,
     "paymentMethod" AS payment_method,
     "AMOUNT" AS order_amount,
     "CREATED" AS created_at,
     "_BATCHED_AT" AS batched_at
  
 FROM {{ source('stripe', 'payment') }}
--  FROM raw.stripe.payment p