with source as (
    select * from {{ source('northwind', 'order_details') }}
),
stg_order_details as (
    select
        cast(orderid as integer) as order_id,
        cast(productid as integer) as product_id,
        cast(replace(unitprice, ',', '.') as float) as unit_price,
        cast(quantity as integer) as quantity,
        cast(replace(discount, ',', '.') as float) as discount,
        unit_price * quantity as gross_sales,
        gross_sales - gross_sales * discount as net_sales
    from source
)
select * from stg_order_details
