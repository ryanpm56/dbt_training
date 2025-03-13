select 
--from raw orders
o.orderid,
o.orderdate, 
o.shipdate,
o.ORDERSELLINGPRICE - o.ORDERCOSTPRICE as orderprofit,
o.ordercostprice,
o.ordersellingprice,
--from raw_customers
c.customername,
c.segment,
c.country,
--from raw_products
p.category, 
p.productname,
p.subcategory
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customers') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_products') }} as p
on o.productid = p.productid

	