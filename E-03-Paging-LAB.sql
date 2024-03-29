USE [Aston Engineer]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployee]    Script Date: 8/13/2021 11:33:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Angel Hughes
-- Create date: 08/12/2021
-- Description:	Retrives Employee record(s)
-- =============================================
ALTER PROCEDURE [dbo].[usp_GetEmployee](		
--change 'create' to 'alter' to change
--procedure after it has been executed
	@EmployeeId	int = null,
	@QueryId	int = 10,
	@PageNumber	int,
	@PageSize	int
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
		select	a.HireDate,
				a.TermDate,
				a.BirthDate,
				a.PersonId,
				a.CreateDate
		from	dbo.Employee a
		where a.EmployeeId = @EmployeeId;

		goto EXIT_SECTION
	end

--end:	GET ITEM SECTION

--begin:	GET COLLECTION SECTION
GET_COLLECTION:
	begin
	SET NOCOUNT ON;

	If(@PageNumber <=0)
		begin
		set @PageNumber = 1;
		end
			if (@PageSize <=0)
			begin
			set @PageSize = 20;
			end

		declare @SkipRows int = (@PageNumber - 1) * @PageSize;

			select	a.HireDate,
					a.TermDate,
					a.BirthDate,
					a.PersonId,
					a.CreateDate
			from	dbo.Employee a
			order by a.PersonID
			OFFSET @SkipRows Rows
				fetch next @PageSize rows only
			return

		goto EXIT_SECTION;
	end



--end:		GET COLLECTION SECTION

--begin:	EXIT SECTION
EXIT_SECTION:
--end:		EXIT_SECTION

END
