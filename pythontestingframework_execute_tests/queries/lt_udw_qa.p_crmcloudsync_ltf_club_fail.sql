

select
s_crmcloudsync_ltf_club.ltf_address_1_line_1
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_area_director is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_area_director,h_crmcloudsync_system_user.system_user_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_area_director as varchar(36)),'z#@$k%&P'))),2)
	 end as area_director_dim_crm_system_user_key
,s_crmcloudsync_ltf_club.ltf_address_1_city as city
,l_crmcloudsync_ltf_club.ltf_mms_club_id as club_id
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_club_regional_manager is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_club_regional_manager,h_crmcloudsync_system_user.system_user_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_club_regional_manager as varchar(36)),'z#@$k%&P'))),2)
	 end as club_regional_manager_dim_crm_system_user_key
,s_crmcloudsync_ltf_club.ltf_address_1_country as country
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_mms_club_id is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_mms_club_id,h_mms_club.club_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(cast(l_crmcloudsync_ltf_club.ltf_mms_club_id as int) as varchar(500)),'z#@$k%&P'))),2)
	 end as dim_club_key
,p_crmcloudsync_ltf_club.bk_hash as dim_crm_ltf_club_key
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_club_team_id is null then '-998'
	 --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_club_team_id,h_crmcloudsync_team.team_id]
	 else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_club_team_id as varchar(36)),'z#@$k%&P'))),2)
	end as dim_crm_team_key
,s_crmcloudsync_ltf_club.ltf_five_letter_club_code
,s_crmcloudsync_ltf_club.ltf_four_letter_club_code
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_general_manager is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_general_manager,h_crmcloudsync_system_user.system_user_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_general_manager as varchar(36)),'z#@$k%&P'))),2)
	 end as general_manager_dim_crm_system_user_key
,p_crmcloudsync_ltf_club.ltf_club_id
,s_crmcloudsync_ltf_club.ltf_lt_work_email
,l_crmcloudsync_ltf_club.ltf_web_specialist_team
,s_crmcloudsync_ltf_club.ltf_club_marketing_name as marketing_name
,s_crmcloudsync_ltf_club.ltf_address_1_postal_code as postal_code
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_regional_sales_lead is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_regional_sales_lead,h_crmcloudsync_system_user.system_user_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_regional_sales_lead as varchar(36)),'z#@$k%&P'))),2)
	 end as regional_sales_lead_dim_crm_system_user_key
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_regional_vice_president is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_regional_vice_president,h_crmcloudsync_system_user.system_user_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_regional_vice_president as varchar(36)),'z#@$k%&P'))),2)
	 end as regional_vice_president_dim_crm_system_user_key
,s_crmcloudsync_ltf_club.ltf_address_1_state_or_province as state_or_province
,s_crmcloudsync_ltf_club.status_code
,s_crmcloudsync_ltf_club.ltf_address_1_telephone_1 as telephone
,case when p_crmcloudsync_ltf_club.bk_hash in ('-997','-998','-999') then p_crmcloudsync_ltf_club.bk_hash
      when l_crmcloudsync_ltf_club.ltf_web_specialist_team is null then '-998'
	  --else util_bk_hash[l_crmcloudsync_ltf_club.ltf_web_specialist_team,h_crmcloudsync_team.team_id]
	  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(l_crmcloudsync_ltf_club.ltf_web_specialist_team as varchar(36)),'z#@$k%&P'))),2)
	 end as web_specialist_dim_crm_team_key
,s_crmcloudsync_ltf_club.ltf_time_zone_code
,l_crmcloudsync_ltf_club.ltf_mem
from p_crmcloudsync_ltf_club
inner join l_crmcloudsync_ltf_club on (p_crmcloudsync_ltf_club.l_crmcloudsync_ltf_club_id=l_crmcloudsync_ltf_club.l_crmcloudsync_ltf_club_id and p_crmcloudsync_ltf_club.bk_hash = l_crmcloudsync_ltf_club.bk_hash)
inner join s_crmcloudsync_ltf_club on (p_crmcloudsync_ltf_club.s_crmcloudsync_ltf_club_id=s_crmcloudsync_ltf_club.s_crmcloudsync_ltf_club_id and p_crmcloudsync_ltf_club.bk_hash = s_crmcloudsync_ltf_club.bk_hash)
order by dim_crm_ltf_club_key