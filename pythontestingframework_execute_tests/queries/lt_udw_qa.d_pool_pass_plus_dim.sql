SET NOCOUNT ON

DECLARE @dv_batch_id [bigint],@begin_extract_date_time [datetime]
set @dv_batch_id = '-1'

IF OBJECT_ID(N'tempdb..#i') IS NOT NULL
BEGIN
	DROP TABLE #i
END

--create table #i with (distribution = hash(bk_hash)) as
select bk_hash
INTO #i
from [dbo].[d_pool_pass_guest_visits]
where dv_batch_id >= @dv_batch_id
  and bk_hash not in ('-999','-998','-997')

IF OBJECT_ID(N'tempdb..#t') IS NOT NULL
BEGIN
	DROP TABLE #t
END
--create table #t --with (distribution = hash(source_table_key))
--as
SELECT Usage.bk_hash AS  source_table_key,
       'd_pool_pass_guest_visits' AS source_table,
       'Outdoor Pool - Guest' AS usage_type,
       Usage.dim_club_key,
       DimDate.dim_date_key AS check_in_dim_date_key,
       CAST(DimDate.standard_date_name + ' ' + DimTime.display_24_hour_time as datetime) check_in_date_time,
       DimDate.calendar_date AS check_in_date,
       DimDate.week_number_in_year AS check_in_week_number_in_year,
       DimDate.day_number_in_week AS check_in_day_number_in_week,
       DimTime.dim_time_key AS check_in_dim_time_key,
       DimTime.hour AS check_in_hour,
       DimTime.minute AS check_in_minute,
       DimTime.display_24_hour_time AS check_in_time_display,
       '-998' AS dim_mms_member_key,
       '-998' AS dim_mms_membership_key,
       NULL AS guest_id,
       NULL AS first_name,
       NULL AS last_name,
       NULL AS gender_abbreviation,
       NULL AS member_age_years,
       NULL AS member_age_months,
       NULL AS delinquent_checkin_flag,
       '-998' check_out_dim_date_key,
       NULL AS check_out_date_time,
       NULL AS check_out_date,
       NULL AS check_out_week_number_in_year,
       NULL AS check_out_day_number_in_week,
       '-998' check_out_dim_time_key,
       NULL AS check_out_hour,
       NULL AS check_out_minute,
       NULL AS check_out_time_display,
       '-998' primary_dim_mms_member_key,
       '-998' check_in_by_dim_mms_member_key,
       '-998' check_out_by_dim_mms_member_key,
       NULL AS length_of_stay_display,
       NULL AS length_of_stay_minutes,
       NULL AS kids_play_check_in_count
INTO #t
FROM [dbo].[d_pool_pass_guest_visits] Usage
    JOIN [dbo].[dim_date] DimDate ON DimDate.dim_date_key = Usage.created_dim_date_key
    JOIN [dbo].[dim_time] DimTime ON DimTime.dim_time_key = Usage.created_dim_time_key
WHERE
    Usage.bk_hash in (select bk_hash from #i)
    and usage.resource_identifier like '%_Pool'

select
    CONVERT(VARCHAR(32), source_table_key) AS source_table_key
    ,source_table
    ,usage_type
    ,dim_club_key
    ,check_in_dim_date_key
    ,check_in_date_time
    ,check_in_date
    ,check_in_week_number_in_year
    ,check_in_day_number_in_week
    ,check_in_dim_time_key
    ,check_in_hour
    ,check_in_minute
    ,check_in_time_display
    ,dim_mms_member_key
    ,dim_mms_membership_key
    ,guest_id
    ,first_name
    ,last_name
    ,gender_abbreviation
    ,member_age_years
    ,member_age_months
    ,delinquent_checkin_flag
    ,check_out_dim_date_key
    ,check_out_date_time
    ,check_out_date
    ,check_out_week_number_in_year
    ,check_out_day_number_in_week
    ,check_out_dim_time_key
    ,check_out_hour
    ,check_out_minute
    ,check_out_time_display
    ,primary_dim_mms_member_key
    ,check_in_by_dim_mms_member_key
    ,check_out_by_dim_mms_member_key
    ,length_of_stay_display
    ,length_of_stay_minutes
    ,kids_play_check_in_count
from #t
order by source_table_key