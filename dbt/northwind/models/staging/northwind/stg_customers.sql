with source as (
    select * from {{ source('northwind', 'customers') }}
),
stg_customers as (
    select
        customerid as customer_id,
        companyname as company_name,
        city,
        country
    from source
)
select * from stg_customers
