select 
--from raw orders
{{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders,
o.orderid,
o.orderdate, 
o.shipdate,
o.ORDERSELLINGPRICE - o.ORDERCOSTPRICE as orderprofit,
o.ordercostprice,
o.ordersellingprice,
--from raw_customers
c.customerid,
c.customername,
c.segment,
c.country,
--from raw_products
p.productid,
p.category, 
p.productname,
p.subcategory,
{{ markup('ordersellingprice','ordercostprice')}} as markup,
d.delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customers') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_products') }} as p
on o.productid = p.productid
left join {{'delivery_team'}} as d
on o.shipmode = d.shipmode
	