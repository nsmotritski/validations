select
	val_acquisition_type_id
	,description
	,inserted_date_time
	,sort_order
	,updated_date_time
	,dim_val_acquisition_type_key
	,inserted_dim_date_key
	,cast (inserted_dim_time_key as int) inserted_dim_time_key
	,cast (updated_dim_date_key as int) updated_dim_date_key
	,cast (updated_dim_time_key as int) updated_dim_time_key
from d_mms_Val_Acquisition_Type
where val_acquisition_type_id is not null