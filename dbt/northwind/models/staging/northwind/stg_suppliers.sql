with source as (
    select * from {{ source('northwind', 'suppliers') }}
),
stg_suppliers as (
    select
        cast(supplierid as integer) as supplier_id,
        companyname as company_name
    from source
)
select * from stg_suppliers
