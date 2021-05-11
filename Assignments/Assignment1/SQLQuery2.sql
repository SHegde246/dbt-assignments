DBCC DROPCLEANBUFFERS
GO

DBCC FREEPROCCACHE
GO

--**************************************************************************************************

select * from musician_million where addr='#312, Willow Street' and age between 20 and 40;

create index ind on musician_million(addr,age) on FG5;
drop index musician_million.ind;

--******************************************************************************************************************
select stage_name, phone_no 
from(musician_million join house on musician_million.addr=house.addr)
where age>30;

create index i on musician_million(addr) on FG5;
drop index musician_million.i;

--*****************************************************************************************************

CREATE TABLE HOUSE_
(
	addr VARCHAR(30),
	landmark VARCHAR(60) NOT NULL,
	phone_no CHAR(10) NOT NULL,

	PRIMARY KEY(addr),
) on FG1;

INSERT INTO HOUSE_ VALUES('#232, Maple Drive', 'Near Pizza Hut', '9642311568'),
			('#663, Sunset Avenue', 'Opposite to Shady Oaks Retirement Home', '8834762245'),
			('#518, Brook Lane', 'Next to Freshmart Supermarket', '7221398992'),
			('#047, Fairview Road', 'Behind Galleria Mall', '9982665724'),
			('#312, Willow Street', 'Near Pizza Hut', '8120046375');

select * from house_;

--***************************************************

set nocount on

select @@TRANCOUNT

begin transaction T2

declare @i int,
       -- @n numeric(10),
        @c varchar(10)

set @i = 500
while @i <= 10000
begin

   --select @n = rand() * 1000000,
         select @c = convert(varchar, @i)

   insert into house_(addr, landmark, phone_no)
   select @c + 'main', 'next to shopping mall', '1234567890'
   --select @n, @c + 'id', 'Stage_Name', 'First_Name', 'M', 'Last_Name', 19, '#7, Maple Road'

   set @i = @i + 1
end
go


commit transaction T2

set nocount off

select count(*) from house_;