
select
address_line_1
,area_director_dim_crm_system_user_key
,city
,club_id
,club_regional_manager_dim_crm_system_user_key
,country
,dim_club_key
,dim_crm_ltf_club_key
,dim_crm_team_key
,five_letter_club_code
,four_letter_club_code
,general_manager_dim_crm_system_user_key
,ltf_club_id
,ltf_lt_work_email
,ltf_web_specialist_team
,marketing_name
,postal_code
,regional_sales_lead_dim_crm_system_user_key
,regional_vice_president_dim_crm_system_user_key
,state_or_province
,status_code
,telephone
,web_specialist_dim_crm_team_key
,ltf_time_zone_code
,ltf_mem
from d_crmcloudsync_ltf_club
order by dim_crm_ltf_club_key