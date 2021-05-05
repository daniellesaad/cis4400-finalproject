{{ config(materialized='table') }}

with agency as (
     select distinct
    {{ dbt_utils.surrogate_key(['agency_name', 'resolution_description']) }} as agency_dim_id,
    agency_name,
    resolution_description

    from `cis-4400-group-project.filtered_311_table.final_complaint_data`
)

select * from agency
