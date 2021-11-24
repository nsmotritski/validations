select
ltf_key_type_id
,ltf_key_id
,val_ltf_key_type_id
,inserted_date_time
,updated_date_time
,case when stage_mms_ltf_key_type.ltf_key_type_id is null then '-998'
     else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(ltf_key_type_id as varchar(36)),'z#@$k%&P'))),2)
     end dim_ltf_key_type_key
,case when stage_mms_ltf_key_type.val_ltf_key_type_id is null then '-998'
     else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(val_ltf_key_type_id as varchar(36)),'z#@$k%&P'))),2)
     end dim_val_ltf_key_type_key
,case when stage_mms_ltf_key_type.inserted_date_time is null then '-998'
     else convert(varchar, stage_mms_ltf_key_type.inserted_date_time, 112)
     end inserted_dim_date_key
,cast (case when stage_mms_ltf_key_type.inserted_date_time is null then '-998'
     else '1' + replace(substring(convert(varchar,stage_mms_ltf_key_type.inserted_date_time,114), 1, 5),':','')
     end as int) inserted_dim_time_key
,cast (case when stage_mms_ltf_key_type.updated_date_time is null then '-998'
     else convert(varchar, stage_mms_ltf_key_type.updated_date_time, 112)
     end as int) updated_dim_date_key
,cast (case when stage_mms_ltf_key_type.updated_date_time is null then '-998'
     else '1' + replace(substring(convert(varchar,stage_mms_ltf_key_type.updated_date_time,114), 1, 5),':','')
     end as int)  updated_dim_time_key
from stage_mms_LTF_Key_Type
where dv_expiration_date_time = '9999-12-31'