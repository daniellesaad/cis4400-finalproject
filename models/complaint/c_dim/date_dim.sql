{{ config(materialized='table') }}

with date as (
    select distinct
     {{ dbt_utils.surrogate_key(['full_date', 'year', 'month', 'month_name', 'day_name']) }} as date_dim_id,
    full_date,
    year,
    month,
    month_name,
    day_name
    

    from `cis-4400-group-project.filtered_311_table.date_dim` 
)
select * from date
inner join `cis-4400-group-project.filtered_311_table.created_date` as c
    on date.full_date = c.created_date
order by created_date
