with source as (
    select * from {{ source('northwind.raw', 'orders') }}
)
select
    order_id,
    customer_id,
    employee_id,
    ship_via as shipper_id,
    order_date,
    ship_postal_code,
    ship_name,
    ship_city,
    ship_country
from source