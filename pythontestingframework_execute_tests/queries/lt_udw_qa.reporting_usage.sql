select
    CONVERT(VARCHAR(32), source_table_key) source_table_key
    ,source_table
    ,usage_type
    ,dim_club_key
    ,check_in_dim_date_key
    ,check_in_date_time
    ,check_in_date
    ,check_in_week_number_in_year
    ,check_in_day_number_in_week
    ,cast (check_in_dim_time_key as int) check_in_dim_time_key
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
from reporting.usage
where  source_table='d_pool_pass_guest_visits'
order by source_table_key