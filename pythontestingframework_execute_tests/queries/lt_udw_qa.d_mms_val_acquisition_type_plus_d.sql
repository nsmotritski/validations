SELECT
LTFKeyOwner.party_id
, mapping.dim_mms_member_key
, MAX(PoolAcqusitionType.description) AS outdoor_pool_access_acquisition_type
, MIN(LTFKeyOwner.ltf_key_owner_from_dim_date_key) AS Pool_Access_From_Date
, MAX(LTFKeyOwner.ltf_key_owner_thru_dim_date_key) AS Pool_Access_Through_Date
, count_big(*) AS cb
FROM [dbo].[d_mms_ltf_key_owner] AS LTFKeyOwner
INNER JOIN [dbo].[d_mms_ltf_key_type] AS LTFKeyType
   ON LTFKeyOwner.ltf_key_id = LTFKeyType.ltf_key_id AND LTFKeyType.Val_LTF_Key_Type_ID = 4
INNER JOIN [dbo].[d_mms_val_acquisition_type] AS PoolAcqusitionType
   ON LTFKeyOwner.val_acquisition_type_id = PoolAcqusitionType.val_acquisition_type_id
INNER JOIN [dbo].[map_ltfeb_party_id_dim_mms_member_key] AS Mapping
   ON LTFKeyOwner.party_id = Mapping.party_id
WHERE LTFKeyOwner.is_current = 'Y'
GROUP BY LTFKeyOwner.party_id, mapping.dim_mms_member_key