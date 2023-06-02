with source as (
    select * from {{ source('northwind', 'suppliers') }}
)
select
    cast(supplierid as integer) as supplier_id,
    companyname as company_name
from source