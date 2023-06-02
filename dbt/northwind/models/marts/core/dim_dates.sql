with stg_orders as (
    select * from {{ ref('stg_orders') }}
),
dim_dates as (
    select
        concat(
            year(order_date),
            case length(month(order_date))
                when 1 then '0' || month(order_date)
                else to_varchar(month(order_date)) 
            end,
            case length(day(order_date))
                when 1 then '0' || day(order_date)
                else to_varchar(day(order_date))
            end
        ) as date_id,
        order_date as date,
        dayofweek(date) as day_of_week,
        month(date) as month,
        monthname(date) as month_name,
        quarter(date) as trimester,
        case
            when month >= 1 and month <= 4 then 1 
            when month >= 5 and month <= 8 then 2
            when month >= 9 and month <= 12 then 3
        end as quarter,
        case
            when month >= 1 and month <= 6 then 1
            when month >= 7 and month <= 12 then 2
        end as semester,
        year(date) as year
    from stg_orders
)
select *
from dim_dates
