{{ config(materialized='table') }}

with w_location_table as (
    select distinct
     {{ dbt_utils.surrogate_key(['weather_id', 'city', 'zip', 'borough']) }} as location_dim_id,
    weather_id, 
    city,
    zip,
    borough

    from `cis-4400-group-project.weather_dataset.final_weather_data`
)
select * from w_location_table
order by weather_id
