with source as (
    select * from {{ source('northwind.raw', 'suppliers') }}
)
select
    supplier_id,
    company_name
from source