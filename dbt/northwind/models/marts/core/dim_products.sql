with stg_products as (
    select * from {{ ref('stg_products') }}
),
stg_categories as (
    select * from {{ ref('stg_categories') }}
),
stg_suppliers as (
    select * from {{ ref('stg_suppliers') }}
),
dim_products as (
    select
        product_id,
        product_name,
        category_name,
        company_name as supplier_name
    from stg_products p
    inner join stg_categories c
        on p.category_id = c.category_id
    inner join stg_suppliers s
        on p.supplier_id = s.supplier_id
)
select * from dim_products
