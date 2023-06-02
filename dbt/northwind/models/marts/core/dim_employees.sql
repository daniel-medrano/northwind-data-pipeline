with stg_employees as (
    select * from {{ ref('stg_employees') }}
),
dim_employees as (
    select
        employee_id,
        full_name
    from stg_employees
)
select *
from dim_employees
