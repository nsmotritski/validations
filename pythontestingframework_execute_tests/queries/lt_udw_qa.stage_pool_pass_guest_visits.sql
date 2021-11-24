    select
    guest_visits_Id
    ,Club_Id
   ,case when stage_pool_pass_guest_visits.club_id is null then '-998'
        else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(stage_pool_pass_guest_visits.club_id as varchar(36)),'z#@$k%&P'))),2)
    end dim_club_key
    ,Employee_Party_Id
    ,Adults_Count
    ,Juniors_Count
    ,Resource_Identifier
    ,Created_Date_time
    ,Updated_Date_time
   ,case when stage_pool_pass_guest_visits.created_date_time is null then '-998'
        else convert(varchar, stage_pool_pass_guest_visits.created_date_time, 112)
    end created_dim_date_key
   ,case when stage_pool_pass_guest_visits.created_date_time is null then '-998'
        else convert(int, '1' + replace(substring(convert(varchar,stage_pool_pass_guest_visits.created_date_time,114), 1, 5),':',''))
    end created_dim_time_key
   ,case when stage_pool_pass_guest_visits.updated_date_time is null then '-998'
        else convert(varchar, stage_pool_pass_guest_visits.updated_date_time, 112)
    end updated_dim_date_key
   ,case when stage_pool_pass_guest_visits.updated_date_time is null then '-998'
        else convert(int, '1' + replace(substring(convert(varchar,stage_pool_pass_guest_visits.updated_date_time,114), 1, 5),':',''))
    end updated_dim_time_key
from stage_pool_pass_guest_visits
where dv_expiration_date_time = '9999-12-31 00:00:00.000'
ORDER BY guest_visits_Id