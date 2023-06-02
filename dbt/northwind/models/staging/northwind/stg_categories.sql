with source as (
    select * from {{ source('northwind', 'categories') }}
),
stg_categories (
    select
        cast(categoryid as integer) as category_id,
        categoryname as category_name
    from source
)
select * from stg_categories
