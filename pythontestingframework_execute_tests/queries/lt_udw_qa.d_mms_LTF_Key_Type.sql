select
    ltf_key_type_id
    ,ltf_key_id
    ,val_ltf_key_type_id
    ,inserted_date_time
    ,updated_date_time
    ,dim_ltf_key_type_key
    ,dim_val_ltf_key_type_key
    ,inserted_dim_date_key
    ,cast (inserted_dim_time_key as int) inserted_dim_time_key
    ,cast (updated_dim_date_key as int) updated_dim_date_key
    ,cast (updated_dim_time_key as int) updated_dim_time_key
from d_mms_LTF_Key_Type
where ltf_key_type_id is not null