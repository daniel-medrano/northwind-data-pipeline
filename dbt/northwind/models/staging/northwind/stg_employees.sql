with source as (
    select * from {{ source('northwind', 'employees') }}
)
select
    cast(employeeid as integer) as employee_id,
    firstname || ' ' || lastname as full_name
from source