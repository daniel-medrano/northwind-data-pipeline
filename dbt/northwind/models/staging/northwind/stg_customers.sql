with source as (
    select * from {{ source('northwind', 'customers') }}
)
select
    customerid as customer_id,
    companyname as company_name,
    city,
    country
from source