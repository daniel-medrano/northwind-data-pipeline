with stg_orders as (
    select * from {{ ref('stg_orders') }}
),
stg_order_details as (
    select * from {{ ref('stg_order_details') }}
),
dim_dates as (
    select * from {{ ref('dim_dates') }}
),
dim_shipping_geographics as (
    select * from {{ ref('dim_shipping_geographics') }}
),
fct_sales as (
    select
        o.order_id,
        product_id,
        customer_id,
        employee_id,
        date_id,
        shipper_id,
        shipping_geographics_id,
        unit_price,
        quantity,
        discount,
        gross_sales,
        net_sales
    from stg_orders o
    inner join stg_order_details od
        on o.order_id = od.order_id
    inner join dim_dates d
        on o.order_date = d.date
    inner join dim_shipping_geographics sg
        on coalesce(o.ship_postal_code, 'NULL') = coalesce(sg.postal_code, 'NULL')
        and coalesce(o.ship_name, 'NULL') = coalesce(sg.location, 'NULL')
        and coalesce(o.ship_city, 'NULL') = coalesce(sg.city, 'NULL')
        and coalesce(o.ship_country, 'NULL') = coalesce(sg.country, 'NULL')
)
select *
from fct_sales