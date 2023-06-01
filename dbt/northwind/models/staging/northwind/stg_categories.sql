with source as (
    select * from {{ source('northwind.raw', 'categories') }}
)
select
    category_id,
    category_name
from source