select
	val_acquisition_type_id
	,description
	,inserted_date_time
	,sort_order
	,updated_date_time
	,case when  stage_mms_val_acquisition_type.val_acquisition_type_id is null then '-998'
		  else convert(char(32),hashbytes('md5',('P%#&z$@k'+isnull(cast(val_acquisition_type_id as varchar(36)),'z#@$k%&P'))),2)
		  end dim_val_acquisition_type_key
	,case when inserted_date_time is null then '-998'
		  else convert(varchar, inserted_date_time, 112)
		  end inserted_dim_date_key
	,cast (case when inserted_date_time is null then '-998'
		  else '1' + replace(substring(convert(varchar,inserted_date_time,114), 1, 5),':','')
		  end as int) inserted_dim_time_key
	,cast (case when updated_date_time is null then '-998'
		  else convert(varchar, updated_date_time, 112)
		  end as int) updated_dim_date_key
	,cast (case when updated_date_time is null then '-998'
		  else '1' + replace(substring(convert(varchar,updated_date_time,114), 1, 5),':','')
		  end as int) updated_dim_time_key
from stage_mms_Val_Acquisition_Type
where dv_expiration_date_time = '9999-12-31'