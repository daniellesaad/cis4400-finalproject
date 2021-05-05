{{ config(materialized='table') }}

with location as (
    select distinct
    {{ dbt_utils.surrogate_key(['incident_zip', 'incident_address', 'city', 'borough']) }} as location_dim_id,
    incident_zip,
    incident_address,
    city,
    borough, 
    latitude,
    longitude

    from `cis-4400-group-project.filtered_311_table.final_complaint_data`
)
select * from location
