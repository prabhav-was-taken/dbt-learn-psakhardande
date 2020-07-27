select OrderID as order_id,PAYMENTMETHOD as payment_method ,AMOUNT/100 as amount,CREATED from raw.stripe.payment
WHERE STATUS IN ('success')