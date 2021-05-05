{{ config(materialized='table') }}

with agency as (
    select agency_dim_id, agency_name
    from {{ ref('agency_dim' )}}

),

dates as (
    select date_dim_id, full_date
    from {{ ref('date_dim' )}}

),

descriptions as (
    select description_dim_id, complaint_type
    from {{ ref('description_dim' )}}
),

location as (
    select location_dim_id, incident_zip, latitude, longitude
    from {{ ref('location_dim' )}}
),

fact_data as (
   SELECT agency_name, created_date, complaint_type, incident_zip, latitude, longitude
   FROM `cis-4400-group-project.filtered_311_table.final_complaint_data`
),

final as (
  select agency_dim_id, date_dim_id, description_dim_id, location_dim_id, full_date
  from fact_data 
       INNER JOIN agency ON fact_data.agency_name = agency.agency_name
       INNER JOIN dates ON fact_data.created_date = dates.full_date
       INNER JOIN descriptions ON fact_data.complaint_type = descriptions.complaint_type
       INNER JOIN location ON fact_data.incident_zip = location.incident_zip
       
)

select * from final






    


