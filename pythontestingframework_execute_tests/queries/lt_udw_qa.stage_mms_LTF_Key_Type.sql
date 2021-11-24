select
	ltf_key_type_id
	,ltf_key_id
	,val_ltf_key_type_id
	,inserted_date_time
	,updated_date_time
from stage_mms_LTF_Key_Type
where dv_expiration_date_time = '9999-12-31'
ORDER BY ltf_key_type_id