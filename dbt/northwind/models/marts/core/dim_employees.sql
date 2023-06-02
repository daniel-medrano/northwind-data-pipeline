with stg_employees as (
    select * from {{ ref('stg_employees') }}
)
select *
from stg_employees