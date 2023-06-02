with source as (
    select * from {{ source('northwind', 'shippers') }}
)
select
    cast(shipperid as integer) as shipper_id,
    companyname as company_name
from source