with source as (
    select * from {{ source('northwind.raw', 'customers') }}
)
select
    customer_id,
    company_name,
    city,
    country
from source