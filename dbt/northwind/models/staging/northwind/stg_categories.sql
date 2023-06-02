with source as (
    select * from {{ source('northwind.raw', 'categories') }}
)
select
    cast(category_id as integer) as category_id,
    category_name
from source