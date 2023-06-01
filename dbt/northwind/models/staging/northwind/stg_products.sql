with source as (
    select * from {{ source('northwind.raw', 'products') }}
)
select
    product_id,
    product_name,
    category_id,
    supplier_id
from source