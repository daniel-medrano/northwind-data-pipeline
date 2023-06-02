with source as (
    select * from {{ source('northwind.raw', 'employees') }}
)
select
    cast(employee_id as integer) as employee_id,
    first_name || ' ' || last_name as full_name
from source