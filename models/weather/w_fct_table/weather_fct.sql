{{ config(materialized='table') }}

with w_date as (
    select *
    from {{ ref('w_date_dim' )}}

),

location as (
    select *
    from {{ ref('w_location_dim' )}}
),

calc as (
    select  
        DailyAverageDryBulbTemperature as avg_temp, DailyMaximumDryBulbTemperature as max_temp, 
        DailyMinimumDryBulbTemperature as min_temp, 
        DailyPrecipitation as inches_precipitation, DailySnowDepth as snow_depth,
        DailySnowfall as snow_fall, DailyAverageRelativeHumidity as humidity, 
        DailyAverageSeaLevelPressure as sea_level_pressure, weather_id
    from `cis-4400-group-project.weather_dataset.final_weather_data`

),

final as (

    select
    location_dim_id, date_dim_id, avg_temp, max_temp, min_temp, inches_precipitation, snow_depth, snow_fall, humidity, sea_level_pressure
        

    from w_date as d
    inner join location as l on d.weather_id = l.weather_id
    inner join calc as c on l.weather_id = c.weather_id
 
)

select distinct * from final
