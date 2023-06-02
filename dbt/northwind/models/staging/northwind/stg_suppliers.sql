with source as (
    select * from {{ source('northwind.raw', 'suppliers') }}
)
select
    cast(supplier_id as integer) as supplier_id,
    company_name
from source