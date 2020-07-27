 {% set payment_methods_query %}
 select distinct PAYMENTMETHOD from raw.stripe.payment
 WHERE STATUS IN ('success')
 order by 1
 {% endset %}
 {% set results = run_query(payment_methods_query) %}
 {% if execute %}
 {# Return the first column #}
 {% set results_list = results.columns[0].values() %}
 {% else %}
 {% set results_list = [] %}
 {% endif %}
 select 
 order_id,
        {% for method in results_list %}
        sum(case when PAYMENTMETHOD = '{{ method }}' then amount else 0 end) as {{ method }}_amount
        {% if not loop.last %},{% endif %}{% endfor %}

 from (
select OrderID as order_id,PAYMENTMETHOD,AMOUNT/100 as amount,CREATED from raw.stripe.payment
WHERE STATUS IN ('success')
 )
 group by order_id