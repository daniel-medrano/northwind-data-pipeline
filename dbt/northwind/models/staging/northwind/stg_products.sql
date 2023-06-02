with source as (
    select * from {{ source('northwind', 'products') }}
),
stg_products as (
    select
        cast(productid as integer) as product_id,
        productname as product_name,
        cast(categoryid as integer) as category_id,
        cast(supplierid as integer) as supplier_id
    from source
)
select * from stg_products
