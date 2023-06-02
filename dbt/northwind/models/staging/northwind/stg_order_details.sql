with source as (
    select * from {{ source('northwind.raw', 'order_details') }}
)
select
    cast(order_id as integer) as order_id,
    cast(product_id as integer) as product_id,
    cast(replace(unit_price, ',', '.') as float) as unit_price,
    cast(quantity as integer) as quantity,
    cast(replace(discount, ',', '.') as float) as discount
from source