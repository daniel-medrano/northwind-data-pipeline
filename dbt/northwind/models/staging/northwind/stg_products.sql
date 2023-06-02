with source as (
    select * from {{ source('northwind.raw', 'products') }}
)
select
    cast(product_id as integer) as product_id,
    product_name,
    cast(category_id as integer) as category_id,
    cast(supplier_id as integer) as supplier_id
from source