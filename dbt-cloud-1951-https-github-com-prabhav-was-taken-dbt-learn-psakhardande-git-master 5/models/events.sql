
with orders as (
    select * from {{ ref('ticketorders') }}
),
charges as(
    select * from {{ ref('ticketcharges') }}
),
refunds as(
    select * from {{ ref('ticketrefunds') }}
),
total as (
    select
    orders.ORDER_CANCELLED,
    orders.EVENT_NAME,
    orders.TICKETS_PURCHASED,
    orders.TOTAL_PAID,

    charges.status as charge_status,
    charges.refunded,
    charges.paid,
    charges.description,

     refunds .status as refund_status



    from orders left join charges on orders.TRANSACTION_ID = charges.id
    left join refunds on charges.id = refunds.charge_id and refunds.charge_id = orders.TRANSACTION_ID
    )
select* from math

