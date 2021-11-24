select
    guest_visits_Id
    ,Club_Id
    ,dim_club_key
    ,Employee_Party_Id
    ,Adults_Count
    ,Juniors_Count
    ,Resource_Identifier
    ,Created_Date_time
    ,Updated_Date_time
    ,created_dim_date_key
    ,created_dim_time_key
    ,updated_dim_date_key
    ,updated_dim_time_key
from d_pool_pass_guest_visits
where dim_club_key not in ('-997','-998','-999')
ORDER BY guest_visits_Id