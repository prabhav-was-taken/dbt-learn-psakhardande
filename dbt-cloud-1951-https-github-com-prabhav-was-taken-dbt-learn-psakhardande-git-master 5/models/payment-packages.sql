with
payments as (
  select OrderID as order_id,PAYMENTMETHOD as payment_method ,AMOUNT/100 as amount,CREATED from raw.stripe.payment
  WHERE STATUS IN ('success')
),
final as (
    select
        order_id,
        {{ dbt_utils.pivot(
            'payment_method',
            dbt_utils.get_column_values(ref('stg_payments'), 'payment_method'),
            then_value = 'amount',
            suffix = '_amount'
        ) }}
    from payments
    group by order_id
)
select * from final