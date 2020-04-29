SELECT
     "orderID" AS order_id,
     p."paymentMethod" AS payment_method,
     p."AMOUNT" AS order_amount,
     p."CREATED" AS created_at,
     p."_BATCHED_AT" AS batched_at
  
 FROM raw.stripe.payment p