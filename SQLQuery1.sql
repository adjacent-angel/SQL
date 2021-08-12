declare @FirstName  varchar(50),
		@LastName	varchar(50),
		@Title		varchar(50);

select @FirstName = a.FirstName,
		@LastName = a.LastName,
		@Title = a.Title
from dbo.Person a
where a.PersonId = 1;

select @FirstName as FirstName,
		@LastName as LastName,
		@Title as Title;

print @FirstName;
print @LastName;
print @Title;