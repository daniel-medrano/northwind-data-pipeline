with source as (
    select * from {{ source('northwind.raw', 'employees') }}
)
select
    employee_id,
    first_name || ' ' || last_name as full_name
from source