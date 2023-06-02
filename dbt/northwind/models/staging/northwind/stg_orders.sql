with source as (
    select * from {{ source('northwind.raw', 'orders') }}
)
select
    cast(order_id as integer) as order_id,
    customer_id,
    cast(employee_id as integer) as employee_id,
    cast(ship_via as integer) as shipper_id,
    cast(order_date as date) as order_date,
    ship_postal_code,
    ship_name,
    ship_city,
    ship_country
from source