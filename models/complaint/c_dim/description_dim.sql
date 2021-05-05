{{ config(materialized='table') }}

with descriptions as (
    select distinct
    {{ dbt_utils.surrogate_key(['complaint_type', 'descriptor']) }} as description_dim_id, 
    complaint_type,
    descriptor
    from `cis-4400-group-project.filtered_311_table.final_complaint_data`
)
select * from descriptions





