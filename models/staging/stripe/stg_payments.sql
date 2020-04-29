SELECT
     "orderID" AS order_id,
     p."paymentMethod" AS payment_method,
     p."AMOUNT" AS order_amount,
     p."CREATED" as created_at,
     p."_BATCHED_AT" as batched_at
  
 FROM raw.stripe.payment p