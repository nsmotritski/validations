SELECT
	Id,
	ClubId,
	EmployeePartyId,
	AdultsCount,
	JuniorsCount,
	ResourceIdentifier
	,CONVERT(datetime,CreatedDate) 'CreatedDate'
    ,CONVERT(datetime,UpdatedDate) 'UpdatedDate'
FROM GuestVisits
WHERE
	CreatedDate >= '1753-01-01'
	OR UpdatedDate >= '1753-01-01'
ORDER BY Id