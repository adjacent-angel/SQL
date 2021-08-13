
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Angel Hughes
-- Create date: 08/12/2021
-- Description:	This procedure retrives Person
--				record(s)
-- =============================================
CREATE PROCEDURE dbo.usp_GetPerson(		
--change 'create' to 'alter' to change
--procedure after it has been executed
	@PersonId	int = null,
	@QueryId	int = 10
)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@QueryId = 10) begin goto GET_ITEM end;
	if(@QueryId = 20) begin goto GET_COLLECTION end;

	goto EXIT_SECTION;


--begin: GET ITEM SECTION
GET_ITEM:
	begin
		select	a.Title,
				a.FirstName,
				a.LastName,
				a.DisplayFirstName,
				a.Gender
		from	dbo.Person a
		where a.PersonId = @PersonId;

		goto EXIT_SECTION
	end

--end:	GET ITEM SECTION

--begin:	GET COLLECTION SECTION
GET_COLLECTION:
	begin
		select	a.Title,
				a.FirstName,
				a.LastName,
				a.DisplayFirstName,
				a.Gender
		from	dbo.Person a
		order by	a.LastName,
					a.FirstName

		goto EXIT_SECTION;
	end



--end:		GET COLLECTION SECTION

--begin:	EXIT SECTION
EXIT_SECTION:
--end:		EXIT_SECTION

END
GO
