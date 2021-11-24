select
	val_acquisition_type_id ValAcquisitionTypeID
	,description Description
	,inserted_date_time InsertedDateTime
	,sort_order SortOrder
	,updated_date_time UpdatedDateTime
from stage_mms_Val_Acquisition_Type
where dv_expiration_date_time = '9999-12-31'
ORDER BY val_acquisition_type_id