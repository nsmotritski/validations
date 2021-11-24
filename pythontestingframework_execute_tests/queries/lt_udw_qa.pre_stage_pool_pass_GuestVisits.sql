SET NOCOUNT ON

select
	Id
	,ClubId
	,EmployeePartyId
	,AdultsCount
	,JuniorsCount
	,ResourceIdentifier
	,CreatedDate
	,UpdatedDate
from pre_stage_pool_pass_GuestVisits
ORDER BY Id