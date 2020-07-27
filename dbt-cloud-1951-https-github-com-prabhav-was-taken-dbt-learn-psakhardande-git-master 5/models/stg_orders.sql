select A.order_id, A.customer_id, A.order_date, B.aamount as amount from 
(
(select
    id as order_id,
    user_id as customer_id,
    order_date,
    status
from raw.jaffle_shop.orders) A 
LEFT JOIN 
(select ID, ORDERID as order_id, 
PAYMENTMETHOD,AMOUNT/100 as aamount from raw.stripe.payment
WHERE STATUS IN ('success')
) B ON A.order_id = B.order_id
)