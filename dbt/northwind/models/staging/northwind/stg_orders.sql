with source as (
    select * from {{ source('northwind', 'orders') }}
),
stg_orders as (
    select
        cast(orderid as integer) as order_id,
        customerid as customer_id,
        cast(employeeid as integer) as employee_id,
        cast(shipvia as integer) as shipper_id,
        cast(orderdate as date) as order_date,
        shippostalcode as ship_postal_code,
        shipname as ship_name,
        shipcity as ship_city,
        shipcountry as ship_country
    from source
)
select * from stg_orders