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
inner join `cis-4400-group-project.weather_dataset.weather_date` as w
    on date.full_date = w.weather_date
order by weather_date


