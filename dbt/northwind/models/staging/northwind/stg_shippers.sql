with source as (
    select * from {{ source('northwind.raw', 'shippers') }}
)
select
    shipper_id,
    company_name
from source