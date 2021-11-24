SET NOCOUNT ON

select
	guest_visits_Id 'Id'
	,Club_Id 'ClubId'
	,Employee_Party_Id 'EmployeePartyId'
	,Adults_Count 'AdultsCount'
	,Juniors_Count 'JuniorsCount'
	,Resource_Identifier 'ResourceIdentifier'
	,Created_Date_time 'CreatedDate'
	,Updated_Date_time 'UpdatedDate'
	from stage_pool_pass_guest_visits
where dv_expiration_date_time = '9999-12-31 00:00:00.000'
ORDER BY guest_visits_Id