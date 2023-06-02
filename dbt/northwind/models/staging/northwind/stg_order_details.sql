with source as (
    select * from {{ source('northwind', 'order_details') }}
)
select
    cast(orderid as integer) as order_id,
    cast(productid as integer) as product_id,
    cast(replace(unitprice, ',', '.') as float) as unit_price,
    cast(quantity as integer) as quantity,
    cast(replace(discount, ',', '.') as float) as discount
from source