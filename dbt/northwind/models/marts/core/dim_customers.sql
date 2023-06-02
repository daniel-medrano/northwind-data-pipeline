with stg_customers as (
    select * from {{ ref('stg_customers') }}
),
dim_customers as (
    select
        customer_id,
        company_name,
        city,
        country
    from stg_customers
)
select * from dim_customers
