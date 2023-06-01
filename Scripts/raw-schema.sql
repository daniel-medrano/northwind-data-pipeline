create database northwind;

create schema northwind.raw;

show integrations;

desc integration s3_integration;

-- Used a storage integration that already existed.
alter storage integration s3_integration 
set storage_allowed_locations = ('s3://data-challenge-ulacit-2023/','s3://data-challenge-ulacit-2023/crimes-dataset/','s3://data-engineering-datasets/northwind/');

create or replace stage northwind_dataset_stage
url = 's3://data-engineering-datasets/northwind/'
file_format = (type = csv field_delimiter = ',' skip_header = 1 skip_blank_lines = true encoding = 'UTF16' field_optionally_enclosed_by = '\"' null_if = (''))
storage_integration = s3_integration;

-- list @northwind_dataset_stage;

create table northwind.raw.categories (
    category_id varchar,
    category_name varchar,
    description varchar
);
copy into northwind.raw.categories from
(select 
    $1 as category_id, 
    $2 as category_name, 
    $3 as description 
from @northwind_dataset_stage/northwind-categories);

create table northwind.raw.customers (
    customer_id varchar,
    company_name varchar,
    contact_name varchar,
    contact_title varchar,
    address varchar,
    city varchar,
    region varchar,
    postal_code varchar,
    country varchar,
    phone varchar,
    fax varchar
);
copy into northwind.raw.customers from 
(select 
    $1 as customer_id, 
    $2 as company_name, 
    $3 as contact_name, 
    $4 as contact_title, 
    $5 as address, 
    $6 as city, 
    $7 as region, 
    $8 as postal_code, 
    $9 as country, 
    $10 as phone, 
    $11 as fax
from @northwind_dataset_stage/northwind-customers);

create or replace table northwind.raw.employees (
    employee_id varchar,
    last_name varchar,
    first_name varchar,
    title varchar,
    title_of_courtesy varchar,
    birth_date varchar,
    hire_date varchar,
    address varchar,
    city varchar,
    region varchar,
    postal_code varchar,
    country varchar,
    home_phone varchar,
    extension varchar,
    reports_to varchar,
    photo_path varchar
);
copy into northwind.raw.employees from
(select 
    $1 as employee_id, 
    $2 as last_name, 
    $3 as first_name, 
    $4 as title, 
    $5 as title_of_courtesy, 
    $6 as birth_date, 
    $7 as hire_date, 
    $8 as address, 
    $9 as city, 
    $10 as region, 
    $11 as postal_code, 
    $12 as country,
    $13 as home_phone,
    $14 as extension,
    $15 as reports_to,
    $16 as photo_path
from @northwind_dataset_stage/northwind-employees);

create table northwind.raw.order_details (
    order_id varchar,
    product_id varchar,
    unit_price varchar,
    quantity varchar,
    discount varchar
);
copy into northwind.raw.order_details from
(select 
    $1 as order_id,
    $2 as product_id,
    $3 as unit_price,
    $4 as quantity,
    $5 as discount
from @northwind_dataset_stage/northwind-order-details);

create table northwind.raw.orders (
    order_id varchar,
    customer_id varchar,
    employee_id varchar,
    order_date varchar,
    required_date varchar,
    shipped_date varchar,
    ship_via varchar,
    freight varchar,
    ship_name varchar,
    ship_address varchar,
    ship_city varchar,
    ship_region varchar,
    ship_postal_code varchar,
    ship_country varchar
);
copy into northwind.raw.orders from
(select 
    $1 as order_id,
    $2 as customer_id,
    $3 as employee_id,
    $4 as order_date,
    $5 as required_date,
    $6 as shipped_date,
    $7 as ship_via,
    $8 as freight,
    $9 as ship_name,
    $10 as ship_address,
    $11 as ship_city,
    $12 as ship_region,
    $13 as ship_postal_code,
    $14 as ship_country
from @northwind_dataset_stage/northwind-orders);

create table northwind.raw.products (
    product_id varchar,
    product_name varchar,
    supplier_id varchar,
    category_id varchar,
    quantity_per_unit varchar,
    unit_price varchar,
    units_in_stock varchar,
    units_on_order varchar,
    reorder_level varchar,
    discontinued varchar
);

copy into northwind.raw.products from 
(select
    $1 as product_id,
    $2 as product_name,
    $3 as supplier_id,
    $4 as category_id,
    $5 as quantity_per_unit,
    $6 as units_in_stock,
    $7 as units_on_order,
    $8 as reorder_level,
    $9 as discontinued
from @northwind_dataset_stage/northwind-products);

create table northwind.raw.shippers (
    shipper_id varchar,
    company_name varchar,
    phone varchar
);
copy into northwind.raw.shippers from
(select
    $1 as shipper_id,
    $2 as company_name,
    $3 as phone
from @northwind_dataset_stage/northwind-shippers);


create table northwind.raw.suppliers (
    supplier_id varchar,
    company_name varchar,
    contact_name varchar,
    contact_title varchar,
    address varchar,
    city varchar,
    region varchar,
    postal_code varchar,
    country varchar,
    phone varchar,
    fax varchar,
    home_page varchar
);
copy into northwind.raw.suppliers from
(select 
    $1 as supplier_id,
    $2 as company_name,
    $3 as contact_name,
    $4 as contact_title,
    $5 as address,
    $6 as city,
    $7 as region,
    $8 as postal_code,
    $9 as country,
    $10 as phone,
    $11 as fax,
    $12 as home_page
from @northwind_dataset_stage/northwind-suppliers);

select 
    $1 as employee_id, 
    $2 as last_name, 
    $3 as first_name, 
    $4 as title, 
    $5 as title_of_courtesy, 
    $6 as birth_date, 
    $7 as hire_date, 
    $8 as address, 
    $9 as city, 
    $10 as region, 
    $11 as postal_code, 
    $12 as country,
    $13 as home_phone,
    $14 as extension,
    $15 as notes,
    $16 as reports_to,
    $17 as photo_path
from @northwind_dataset_stage/northwind-employees-02;

grant usage on database northwind to role pc_dbt_db_picker_role;
grant usage on schema northwind.raw to role pc_dbt_db_picker_role; 
grant select on all tables in schema northwind.raw to role pc_dbt_db_picker_role;