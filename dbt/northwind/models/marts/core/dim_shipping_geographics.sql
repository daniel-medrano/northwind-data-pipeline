with stg_orders as (
    select * from {{ ref('stg_orders') }}
),
dim_shipping_geographics as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['ship_postal_code', 'ship_name', 'ship_city', 'ship_country']) }} as shipping_geographics_id,
        ship_postal_code as postal_code,
        ship_name as location,
        ship_city as city,
        ship_country as country
    from stg_orders
)
select *
from dim_shipping_geographics