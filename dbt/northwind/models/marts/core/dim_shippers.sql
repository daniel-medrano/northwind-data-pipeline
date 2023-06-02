with stg_shippers as (
    select * from {{ ref('stg_shippers') }}
),
dim_shippers as (
    select
        shipper_id,
        company_name
    from stg_shippers
)
select *
from dim_shippers
