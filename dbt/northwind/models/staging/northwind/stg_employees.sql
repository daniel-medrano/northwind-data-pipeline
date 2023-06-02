with source as (
    select * from {{ source('northwind', 'employees') }}
),
stg_employees as (
    select
        cast(employeeid as integer) as employee_id,
        firstname || ' ' || lastname as full_name
    from source
)
select * from stg_employees
