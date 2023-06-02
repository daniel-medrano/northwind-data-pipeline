with source as (
    select * from {{ source('northwind', 'shippers') }}
),
stg_shippers as (
    select
        cast(shipperid as integer) as shipper_id,
        companyname as company_name
    from source
)
select * from stg_shippers
