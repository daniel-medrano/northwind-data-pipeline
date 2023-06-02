with source as (
    select * from {{ source('northwind.raw', 'shippers') }}
)
select
    cast(shipper_id as integer) as shipper_id,
    company_name
from source