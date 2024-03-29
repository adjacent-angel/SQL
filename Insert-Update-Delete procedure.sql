SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Angel Hughes
-- Create date: 08/12/2021
-- Description:	Procedure inserts, updates or
--				deletes Person
-- =============================================
CREATE PROCEDURE dbo.usp_ExecutePerson(
	@PersonId			int = null,
	@Title				varchar(10) = null,
	@FirstName			varchar(50) = null,
	@LastName			varchar(50) = null,
	@DisplayFirstName	varchar(50) = null,
	@Gender				char(1) = null,
	@QueryId			int = 10,
	@ReturnValue		int = null output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if(@QueryID = 10) begin goto INSERT_ITEM end;
	if(@QueryID = 20) begin goto UPDATE_ITEM end;
	if(@QueryID = 30) begin goto DELETE_ITEM end;

	goto EXIT_SECTION;

--BEGIN		INSERT_SECTION
INSERT_ITEM:
	begin
		insert into dbo.Person(	Title,
								FirstName,
								LastName,
								CreateDate,
								DisplayFirstName,
								Gender)
		values(	@Title,
				@FirstName,
				@LastName,
				getdate(),
				@DisplayFirstName,
				@Gender);

		set @ReturnValue = SCOPE_IDENTITY();

		goto EXIT_SECTION
	end
--END		INSERT_SECTION

--BEGIN		UPDATE_SECTION
UPDATE_ITEM:
	begin
		update	dbo.Person
		set		Title		= isnull(@Title, Title),
				FirstName	= isnull(@FirstName, FirstName),
				LastName	= isnull(@LastName, LastName),
				DisplayFirstName = isnull (@DisplayFirstName, DisplayFirstName),
				Gender		= isnull(@Gender, Gender)
		where	PersonId = @PersonId;

		set @ReturnValue = @PersonId;

		goto EXIT_SECTION;
	end
--END		UPDATE_SECTION

--BEGIN		DELETE_SECTION
DELETE_ITEM:
	begin
		delete
		from	dbo.Person
		where	PersonId = @PersonId;

		set @ReturnValue = @PersonId;

		goto EXIT_SECTION;
	end
--END		DELETE_SECTION

--BEGIN		EXIT_SECTION
EXIT_SECTION:
--END		EXIT_SECTION
END
GO
