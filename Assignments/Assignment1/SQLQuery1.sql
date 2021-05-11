CREATE DATABASE [spin_it_dbt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'spin_it_dbt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\spin_it_dbt.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dblog', FILENAME = N'D:\DBT\dblog_new\spin_it_dbt_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO

--******************************************************************************************

--creating two filegroups

USE [master]
GO
ALTER DATABASE [spin_it_dbt] ADD FILEGROUP [FG1]
GO
ALTER DATABASE [spin_it_dbt] ADD FILEGROUP [FG2]
GO

--********************************************************************************************

--adding two files (on C and D drives) to these filegroups

USE [master]
GO
ALTER DATABASE [spin_it_dbt] ADD FILE ( NAME = N'File1', FILENAME = N'C:\DBT_\fg\File1.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [FG1]
GO
ALTER DATABASE [spin_it_dbt] ADD FILE ( NAME = N'File2', FILENAME = N'D:\DBT_\fg\File2.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [FG2]
GO

USE [spin_it_dbt]
GO

--**********************************************************************************************

--creating tables on these files

CREATE TABLE MUSICIAN
(
	musician_id CHAR(8),
	stage_name VARCHAR(20) NOT NULL,
	fname VARCHAR(15) NOT NULL,
	minit CHAR(1),
	lname VARCHAR(15) NOT NULL,
	age INT NOT NULL,
	addr VARCHAR(30),

	PRIMARY KEY(musician_id),
	UNIQUE(stage_name)
) ON FG1;

CREATE TABLE INSTRUMENT
(
	instrument_id CHAR(6),
	i_name VARCHAR(20) NOT NULL,
	i_type VARCHAR(10) NOT NULL,
	
	PRIMARY KEY(instrument_id)
) ON FG2;


CREATE TABLE ALBUM
(
	album_id CHAR(5),
	a_title VARCHAR(30) NOT NULL,
	type VARCHAR(15) NOT NULL,
	copyright_date DATE NOT NULL CHECK(copyright_date > '1973-04-12'),
	musician_id CHAR(8) NOT NULL,

	PRIMARY KEY(album_id)
) ON FG1;


CREATE TABLE SONG
(
	song_id CHAR(5),
	s_title VARCHAR(30) NOT NULL,
	album_id CHAR(5) NOT NULL,
	
	PRIMARY KEY(song_id)
) ON FG2;


CREATE TABLE HOUSE
(
	addr VARCHAR(30),
	landmark VARCHAR(60) NOT NULL,
	phone_no CHAR(10) NOT NULL,

	PRIMARY KEY(addr),
	UNIQUE(phone_no)
) ON FG1;

CREATE TABLE PERFORMS
(
	musician_id CHAR(8),
	song_id CHAR(5),

	PRIMARY KEY(musician_id, song_id)
) ON FG2;

CREATE TABLE PLAYS
(
	musician_id CHAR(8),
	instrument_id CHAR(6),

	PRIMARY KEY(musician_id, instrument_id)
) ON FG1;

CREATE TABLE AUTHOR
(
	fn VARCHAR(15),
	ln VARCHAR(15),
	song_id CHAR(5),

	PRIMARY KEY(fn, ln, song_id)
) ON FG2;


ALTER TABLE MUSICIAN
ADD FOREIGN KEY(addr) REFERENCES HOUSE(addr) ON DELETE SET NULL   ON UPDATE CASCADE;

ALTER TABLE ALBUM
ADD FOREIGN KEY(musician_id) REFERENCES MUSICIAN(musician_id) ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE SONG ADD FOREIGN KEY(album_id) REFERENCES ALBUM(album_id) ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE PERFORMS ADD FOREIGN KEY(musician_id) REFERENCES MUSICIAN(musician_id) ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE PERFORMS
ADD FOREIGN KEY(song_id) REFERENCES SONG(song_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE PLAYS
ADD FOREIGN KEY(musician_id) REFERENCES MUSICIAN(musician_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE PLAYS
ADD FOREIGN KEY(instrument_id) REFERENCES INSTRUMENT(instrument_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE AUTHOR
ADD FOREIGN KEY(song_id) REFERENCES SONG(song_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

--*****************************************************

SELECT *
FROM sys.filegroups
GO

SELECT 
name as [FileName],
physical_name as [FilePath] 
FROM sys.database_files
where type_desc = 'ROWS'
GO

SELECT o.[name], o.[type], i.[name], i.[index_id], f.[name] FROM sys.indexes i
INNER JOIN sys.filegroups f
ON i.data_space_id = f.data_space_id
INNER JOIN sys.all_objects o
ON i.[object_id] = o.[object_id] WHERE i.data_space_id = f.data_space_id
AND i.data_space_id = 2 -- Filegroup
GO


SELECT o.[name], o.[type], i.[name], i.[index_id], f.[name] FROM sys.indexes i
INNER JOIN sys.filegroups f
ON i.data_space_id = f.data_space_id
INNER JOIN sys.all_objects o
ON i.[object_id] = o.[object_id] WHERE i.data_space_id = f.data_space_id
AND i.data_space_id = 3 -- Filegroup
GO

--****************************************************************************************

USE [master]
GO
ALTER DATABASE [spin_it_dbt] ADD FILEGROUP [FG3]
GO
ALTER DATABASE [spin_it_dbt] ADD FILEGROUP [FG4]
GO

USE [master]
GO
ALTER DATABASE [spin_it_dbt] ADD FILE ( NAME = N'File3', FILENAME = N'C:\DBT_\fg\File3.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [FG3]
GO
ALTER DATABASE [spin_it_dbt] ADD FILE ( NAME = N'File4', FILENAME = N'D:\DBT_\fg\File4.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [FG4]
GO

USE [spin_it_dbt]
GO

--**************************************************************

CREATE PARTITION FUNCTION siPF1 (int)  
    AS RANGE LEFT FOR VALUES (1000) ;  
GO  

CREATE PARTITION SCHEME siPS1  
    AS PARTITION siPF1  
    TO (FG3, FG4) ;  
GO  

CREATE TABLE musician_partition (sl_no INT NOT NULL,
								musician_id CHAR(8) NOT NULL,
								stage_name VARCHAR(20) NOT NULL,
								fname VARCHAR(15) NOT NULL,
								minit CHAR(1) NOT NULL,
								lname VARCHAR(15) NOT NULL,
								age INT NOT NULL,
								addr VARCHAR(30) NOT NULL,

								PRIMARY KEY(sl_no)) 
    ON siPS1 (sl_no) 
GO  


INSERT INTO musician_partition VALUES(3, 'SIMUS177', 'Pearl Waters', 'Ava', 'Q', 'Waters', 27, '#312, Willow Street');

INSERT INTO musician_partition VALUES(180, 'SIMUS096', 'Trixie', 'Mae', 'C', 'Tudgeman', 34, '#232, Maple Drive');

INSERT INTO musician_partition VALUES(2127, 'SIMUS472', 'Sammy J', 'Samuel', 'P', 'Johnson', 43, '#518, Brook Lane');



SELECT 
p.partition_number AS PartitionNumber,
f.name AS PartitionFilegroup, 
p.rows AS NumberOfRows 
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Reports'

select * from musician_partition;
--**************************************************************************
select distinct object_name(object_id) from sys.partitions
group by object_id, index_id
having COUNT(*) > 1;



SELECT SCHEMA_NAME(c.SCHEMA_ID) [schema name],
OBJECT_NAME(a.OBJECT_ID) 
,
a.name [index name], a.type_desc [index type]
FROM (sys.indexes a INNER JOIN sys.tables c
ON a.OBJECT_ID = c.OBJECT_ID)
INNER JOIN sys.data_spaces b ON a.data_space_id = b.data_space_id
WHERE b.type='PS'


--*********************************************************************************************************************
--this one works
SELECT

DB_NAME() AS 'DatabaseName'

,OBJECT_NAME(p.OBJECT_ID) AS 'TableName'

,p.index_id AS 'IndexId'

,CASE

WHEN p.index_id = 0 THEN 'HEAP'

ELSE i.name

END AS 'IndexName'

,p.partition_number AS 'PartitionNumber'

,prv_left.VALUE AS 'LowerBoundary'

,prv_right.VALUE AS 'UpperBoundary'

,CASE

WHEN fg.name IS NULL THEN ds.name

ELSE fg.name

END AS 'FileGroupName'

,CAST(p.used_page_count * 0.0078125 AS NUMERIC(18,2)) AS 'UsedPages_MB'

,CAST(p.in_row_data_page_count * 0.0078125 AS NUMERIC(18,2)) AS 'DataPages_MB'

,CAST(p.reserved_page_count * 0.0078125 AS NUMERIC(18,2)) AS 'ReservedPages_MB'

,CASE

WHEN p.index_id IN (0,1) THEN p.ROW_COUNT

ELSE 0

END AS 'RowCount'

,CASE

WHEN p.index_id IN (0,1) THEN 'data'

ELSE 'index'

END 'Type'

FROM sys.dm_db_partition_stats p

INNER JOIN sys.indexes i

ON i.OBJECT_ID = p.OBJECT_ID AND i.index_id = p.index_id

INNER JOIN sys.data_spaces ds

ON ds.data_space_id = i.data_space_id

LEFT OUTER JOIN sys.partition_schemes ps

ON ps.data_space_id = i.data_space_id

LEFT OUTER JOIN sys.destination_data_spaces dds

ON dds.partition_scheme_id = ps.data_space_id

AND dds.destination_id = p.partition_number

LEFT OUTER JOIN sys.filegroups fg

ON fg.data_space_id = dds.data_space_id

LEFT OUTER JOIN sys.partition_range_values prv_right

ON prv_right.function_id = ps.function_id

AND prv_right.boundary_id = p.partition_number

LEFT OUTER JOIN sys.partition_range_values prv_left

ON prv_left.function_id = ps.function_id

AND prv_left.boundary_id = p.partition_number - 1

WHERE

OBJECTPROPERTY(p.OBJECT_ID, 'ISMSSHipped') = 0

--********************************************************************************************************************

set nocount on

select @@TRANCOUNT

begin transaction T1

declare @i int,
        @n numeric(10),
        @c varchar(10)

set @i = 1
while @i <= 1000000
begin

   select @n = rand() * 1000000,
          @c = convert(varchar, @i)

   insert into MUSICIAN_million(sl_no, musician_id, stage_name, fname, minit, lname, age, addr)
   select @n, @c + 'id', 'Stage_Name', 'First_Name', 'M', 'Last_Name', 19, '#7, Maple Road'

   set @i = @i + 1
end
go


commit transaction T1

set nocount off


select count(*) from musician_million;
select * from musician_million;



select count(*) from musician_partition;
select count(*) from musician;

CREATE TABLE MUSICIAN_million
(
	sl_no INT NOT NULL,
	musician_id CHAR(20) NOT NULL,
	stage_name VARCHAR(20) NOT NULL,
	fname VARCHAR(15) NOT NULL,
	minit CHAR(1) NOT NULL,
	lname VARCHAR(15) NOT NULL,
	age INT NOT NULL,
	addr VARCHAR(30) NOT NULL,

	PRIMARY KEY(musician_id),
) ON FG2;

--drop table MUSICIAN_million;



--********************************

sp_helpindex musician_million
dbcc checktable (musician_million)
dbcc showcontig(musician_million)
DBCC INDEXDEFRAG(spin_it_dbt,musician_million)

delete from MUSICIAN_million where sl_no between 30000 and 40000

delete from MUSICIAN_million where sl_no between 130000 and 140000

delete from MUSICIAN_million where sl_no between 230000 and 240000

delete from MUSICIAN_million where sl_no between 330000 and 340000

delete from MUSICIAN_million where sl_no between 430000 and 440000


dbcc checktable (musician_million)
dbcc showcontig(musician_million)
DBCC INDEXDEFRAG(spin_it_dbt,musician_million)
--**************************************************************************************************************

INSERT INTO HOUSE VALUES('#232, Maple Drive', 'Near Pizza Hut', '9642311568'),
			('#663, Sunset Avenue', 'Opposite to Shady Oaks Retirement Home', '8834762245'),
			('#518, Brook Lane', 'Next to Freshmart Supermarket', '7221398992'),
			('#047, Fairview Road', 'Behind Galleria Mall', '9982665724'),
			('#312, Willow Street', 'Near Pizza Hut', '8120046375');


INSERT INTO MUSICIAN VALUES('SIMUS010', 'Zazu', 'Ryan', 'S', 'Aaron', 24, '#663, Sunset Avenue'),
			   ('SIMUS215', 'Reggie Olsen', 'Kyle', 'B', 'Davis', 32, '#312, Willow Street'),
			   ('SIMUS003', 'Luna Jade', 'Natalie', 'U', 'Baker', 22, '#663, Sunset Avenue'),
			   ('SIMUS096', 'Trixie', 'Mae', 'C', 'Tudgeman', 34, '#232, Maple Drive'),
			   ('SIMUS472', 'Sammy J', 'Samuel', NULL, 'Johnson', 43, '#518, Brook Lane'),
			   ('SIMUS331', 'Greta', 'Greta', 'G', 'Smith', 54, '#312, Willow Street'),
			   ('SIMUS108', 'Benj Benson', 'Benjamin', NULL, 'Turner', 26, '#047, Fairview Road'),
			   ('SIMUS588', 'Misty', 'Natalie', NULL, 'Vermont', 38, '#518, Brook Lane'),
			   ('SIMUS239', 'Stubot','Stuart', 'P', 'Abbott', 33, '#663, Sunset Avenue'),
			   ('SIMUS177', 'Pearl Waters', 'Ava', 'Q', 'Waters', 27, '#312, Willow Street');


INSERT INTO INSTRUMENT VALUES('INS001', 'Saxophone', 'Alto'),
			     ('INS002', 'Saxophone', 'Tenor'),
			     ('INS003', 'Guitar', 'Acoustic'),
			     ('INS004', 'Guitar', 'Electric'),
			     ('INS005', 'Guitar', 'Bass'),
			     ('INS006', 'Keyboard', 'Electronic'),
			     ('INS007', 'Drum', 'Rock/Pop'),
			     ('INS008', 'Violin', 'Classical'),
			     ('INS009', 'Violin', 'Electric'),
		     	     ('INS010', 'Flute', 'Standard'),
			     ('INS011', 'Flute', 'Piccolo');


INSERT INTO ALBUM VALUES('AL003', 'Sleepless Slumber', 'Studio Album', '2010-11-23', 'SIMUS010'),
			('AL006', 'Everyday', 'EP', '2012-04-02', 'SIMUS010'),
			('AL015', 'Old Town', 'Live Album', '2015-10-14', 'SIMUS215'),
			('AL008', 'Evergreen', 'Studio Album', '2018-07-19', 'SIMUS003'),
			('AL007', 'Mystique', 'Studio Album', '2016-03-21', 'SIMUS003'),
			('AL019', 'Freestyle', 'EP', '2007-06-03', 'SIMUS096'),
			('AL016', 'Beats', 'EP', '2008-05-08', 'SIMUS096'),
			('AL012', 'Poet''s Soul', 'Live Album', '1998-12-04', 'SIMUS472'),
			('AL020', 'Orbit', 'Studio Album', '1990-10-22', 'SIMUS331'),
			('AL014', 'The Other Side', 'EP', '2019-02-01', 'SIMUS108'),
			('AL023', 'Foggy Memory', 'Studio Album', '2002-09-30', 'SIMUS588'),
			('AL024', 'Electric Heart', 'Studio Album', '2009-08-31', 'SIMUS239'),
			('AL025', 'Go With It', 'Live Album', '2014-01-29', 'SIMUS177');


INSERT INTO SONG VALUES ('SG001', 'So Awake', 'AL003'),
			('SG002', 'Dreaming', 'AL003'),
			('SG003', 'Lucid', 'AL003'),
			('SG004', 'So Awake', 'AL003'),
			('SG005', 'I''m Snoring', 'AL003'),

			('SG006', 'Tomorrow', 'AL006'),
			('SG007', 'Yesterday', 'AL006'),

			('SG008', 'Tumbleweed', 'AL015'),
			('SG009', 'I''ve Got My Banjo', 'AL015'),
			('SG010', 'Reach For The Sky', 'AL015'),

			('SG011', 'Emerald Sea', 'AL008'),
			('SG012', 'Terrestrial Turf', 'AL008'),

			('SG013', 'Charisma', 'AL007'),
			('SG014', 'Enchanté', 'AL007'),
			('SG015', 'Charmed', 'AL007'),

			('SG016', 'Graffiti Mind', 'AL019'),
			('SG017', 'Beating The Box', 'AL019'),
			('SG018', 'Underground Noises', 'AL019'),

			('SG019', 'Break It Down', 'AL016'),
			('SG020', 'Shoutout', 'AL016'),

			('SG021', 'The Charlatan''s Charleston', 'AL012'),
			('SG022', 'Feel The Rhythm', 'AL012'),

			('SG023', 'I''m soaring', 'AL020'),
			('SG024', 'Out Of This World', 'AL020'),
			('SG025', 'Flying High', 'AL020'),

			('SG026', 'Emotions', 'AL014'),
			('SG027', 'Speak To Me', 'AL014'),
			('SG028', 'Inhale, Exhale', 'AL014'),

			('SG029', 'Almost There', 'AL023'),
			('SG030', 'Do You Remember?', 'AL023'),
			('SG031', 'Starting To Forget', 'AL023'),
			('SG032', 'It''s Coming Back', 'AL023'),

			('SG033', 'All The Components', 'AL024'),
			('SG034', 'Bits And Pieces', 'AL024'),
			('SG035', 'Crack The Code', 'AL024'),

			('SG036', 'Flow', 'AL025'),
			('SG037', 'Serenity', 'AL025');


INSERT INTO PERFORMS VALUES     ('SIMUS010','SG001'),
				('SIMUS010','SG002'),
				('SIMUS010','SG003'),
				('SIMUS010','SG004'),
				('SIMUS010','SG005'),
				('SIMUS010','SG006'),
				('SIMUS010','SG007'),
				('SIMUS010','SG008'),
				('SIMUS010','SG013'),
				('SIMUS010','SG037'),

				('SIMUS215','SG008'),
				('SIMUS215','SG009'),
				('SIMUS215','SG010'),
				('SIMUS215','SG023'),
				('SIMUS215','SG027'),
				('SIMUS215','SG031'),

				('SIMUS003','SG011'),
				('SIMUS003','SG012'),
				('SIMUS003','SG013'),
				('SIMUS003','SG014'),
				('SIMUS003','SG015'),
				('SIMUS003','SG036'),
				('SIMUS003','SG037'),
				('SIMUS003','SG025'),

				('SIMUS096','SG016'),
				('SIMUS096','SG017'),
				('SIMUS096','SG018'),
				('SIMUS096','SG019'),
				('SIMUS096','SG020'),
				('SIMUS096','SG023'),
				('SIMUS096','SG032'),

				('SIMUS472','SG021'),
				('SIMUS472','SG022'),
				('SIMUS472','SG008'),
				('SIMUS472','SG009'),
				('SIMUS472','SG015'),
				('SIMUS472','SG025'),

				('SIMUS331','SG023'),
				('SIMUS331','SG024'),
				('SIMUS331','SG025'),
				('SIMUS331','SG028'),
				('SIMUS331','SG030'),
				('SIMUS331','SG033'),

				('SIMUS108','SG026'),
				('SIMUS108','SG027'),
				('SIMUS108','SG028'),
				('SIMUS108','SG019'),
				('SIMUS108','SG022'),
				('SIMUS108','SG035'),

				('SIMUS588','SG029'),
				('SIMUS588','SG030'),
				('SIMUS588','SG031'),
				('SIMUS588','SG032'),
				('SIMUS588','SG033'),
				('SIMUS588','SG020'),
				('SIMUS588','SG018'),

				('SIMUS239','SG033'),
				('SIMUS239','SG034'),
				('SIMUS239','SG035'),
				('SIMUS239','SG016'),
				('SIMUS239','SG019'),
				('SIMUS239','SG036'),

				('SIMUS177','SG036'),
				('SIMUS177','SG037'),
				('SIMUS177','SG012'),
				('SIMUS177','SG013'),
				('SIMUS177','SG006'),
				('SIMUS177','SG002'),
				('SIMUS177','SG003');


INSERT INTO PLAYS VALUES        ('SIMUS010', 'INS006'),
				('SIMUS010', 'INS003'),
				('SIMUS010', 'INS005'),

				('SIMUS215', 'INS003'),
				('SIMUS215', 'INS008'),
				('SIMUS215', 'INS001'),
				('SIMUS215', 'INS002'),

				('SIMUS003', 'INS008'),
				('SIMUS003', 'INS009'),
				('SIMUS003', 'INS010'),
				('SIMUS003', 'INS011'),
				
				('SIMUS096', 'INS002'),
				('SIMUS096', 'INS004'),
				('SIMUS096', 'INS007'),
				('SIMUS096', 'INS009'),

				('SIMUS472', 'INS001'),
				('SIMUS472', 'INS002'),
				('SIMUS472', 'INS003'),
				('SIMUS472', 'INS004'),
				('SIMUS472', 'INS005'),

				('SIMUS331', 'INS001'),
				('SIMUS331', 'INS008'),

				('SIMUS108', 'INS003'),
				('SIMUS108', 'INS010'),
				('SIMUS108', 'INS011'),

				('SIMUS588', 'INS010'),

				('SIMUS239', 'INS006'),
				('SIMUS239', 'INS009'),

				('SIMUS177', 'INS010'),
				('SIMUS177', 'INS008'),
				('SIMUS177', 'INS007');


INSERT INTO AUTHOR VALUES('Brittney', 'Hanna', 'SG001'),
			('Charlie', 'Adams', 'SG001'),

			('Paige', 'Thornhart', 'SG002'),

			('Rachel', 'Evans', 'SG003'),
			('Bertha', 'Evans', 'SG003'),

			('Arnold', 'Smith', 'SG004'),

			('Kathy', 'Baird', 'SG005'),

			('Monica', 'Hanna', 'SG006'),
			('Emily', 'Pugh', 'SG006'),

			('Cody', 'Baker', 'SG007'),

			('Asa', 'Baldwin', 'SG008'),

			('Faith', 'Robins', 'SG009'),

			('Kelly', 'Newton', 'SG010'),
			('Denny', 'Kerr', 'SG010'),
			('Manny', 'Jacobs', 'SG010'),
			
			('Sarah', 'Newton', 'SG011'),
			('Sarah', 'Hill', 'SG011'),

			('Kelly', 'Newton', 'SG012'),
			('Monica', 'Hanna', 'SG012'),
			
			('Cody', 'Baker', 'SG013'),
			('Arnold', 'Smith', 'SG013'),

			('Paige', 'Thornhart', 'SG014'),
			('Kathy', 'Baird', 'SG014'),
			('Cody', 'Baker', 'SG014'),

			('Charlie', 'Adams', 'SG015'),
			('Denny', 'Kerr', 'SG015'),

			('Sarah', 'Hill', 'SG016'),
			('Roxy', 'Blackmore', 'SG016'),	
			('Marie', 'Wall', 'SG016'),
			('Jessica', 'Thomas', 'SG016'),	

			('Marie', 'Wall', 'SG017'),
			('Kylie', 'Krueger', 'SG017'),

			('Jerome', 'Summers', 'SG018'),
			('Ed', 'Burton', 'SG018'),
			('Jessica', 'Thomas', 'SG018'),	

			('Mark', 'Thomas', 'SG019'),
		
			('Jessica', 'Thomas', 'SG020'),
			('Mike', 'Ramsey', 'SG020'),

			('Chloe', 'Johnson', 'SG021'),
			('Arnold', 'Smith', 'SG021'),

			('Jordan', 'Adams', 'SG022'),

			('Ella', 'Jacobs', 'SG023'),

			('Arthur', 'Baxter', 'SG024'),
			('Faith', 'Robins', 'SG024'),

			('Asa', 'Baldwin', 'SG025'),
			('Paige', 'Thornhart', 'SG025'),

			('Mike', 'Ramsey', 'SG026'),

			('Roxy', 'Blackmore', 'SG027'),	
			('Ed', 'Burton', 'SG027'),
			('Steve', 'Munroe', 'SG027'),
			('Jeffery', 'Noel', 'SG027'),

			('Adam', 'Mora', 'SG028'),

			('Brad', 'Snyder', 'SG029'),
			('Jeffery', 'Noel', 'SG029'),

			('Jim', 'Crosby', 'SG030'),

			('Melissa', 'Gomez', 'SG031'),

			('Toby', 'Sanchez', 'SG032'),
			('Alex', 'Wong', 'SG032'),

			('Jeffery', 'Noel', 'SG033'),
			('Melissa', 'Gomez', 'SG033'),
			('James', 'Sullivan', 'SG033'),
			('Peter', 'Carter', 'SG033'),

			('Melissa', 'Gomez', 'SG034'),
			('Harold', 'Parker', 'SG034'),
			('Megan', 'Diaz', 'SG034'),
			('Alex', 'Wong', 'SG034'),

			('Ron', 'Goldstein', 'SG035'),

			('Tom', 'Holt', 'SG036'),
			('Toby', 'Sanchez', 'SG036'),

			('Josh', 'McKinley', 'SG037'),
			('Katy', 'Reilly', 'SG037'),
			('Toby', 'Sanchez', 'SG037'),
			('Peter', 'Carter', 'SG037');

--**********************************************
DBCC DROPCLEANBUFFERS
GO

DBCC FREEPROCCACHE
GO



select * from song;
sp_helpindex musician;


ALTER DATABASE [spin_it_dbt] ADD FILEGROUP [FG5]
GO

USE [master]
GO
ALTER DATABASE [spin_it_dbt] ADD FILE ( NAME = N'File5', FILENAME = N'D:\DBT_\fg\File5.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [FG5]
GO

SELECT i_name, COUNT(*)
FROM INSTRUMENT
GROUP BY i_name;

CREATE INDEX ins_ind on INSTRUMENT (i_name) ON FG5;
DROP INDEX INSTRUMENT.ins_ind;


SELECT addr FROM MUSICIAN where age=24 or age=34;
CREATE INDEX m_ind on MUSICIAN(addr,age) on FG5;
DROP INDEX MUSICIAN.m_ind;
sp_helpindex musician;

--************************************************************************
select count(*) from musician_million;
select * from musician_million;

INSERT INTO musician_million VALUES(31445,'SIMUS010', 'Zazu', 'Ryan', 'S', 'Aaron', 24, '#663, Sunset Avenue'),
			   (230076,'SIMUS215', 'Reggie Olsen', 'Kyle', 'B', 'Davis', 32, '#312, Willow Street'),
			   (437800,'SIMUS003', 'Luna Jade', 'Natalie', 'U', 'Baker', 22, '#663, Sunset Avenue'),
			   (38604,'SIMUS096', 'Trixie', 'Mae', 'C', 'Tudgeman', 34, '#232, Maple Drive'),
			   (233000,'SIMUS472', 'Sammy J', 'Samuel', 'K', 'Johnson', 43, '#518, Brook Lane'),
			   (37983,'SIMUS331', 'Greta', 'Greta', 'G', 'Smith', 54, '#312, Willow Street'),
			   (238115,'SIMUS108', 'Benj Benson', 'Benjamin', 'N', 'Turner', 26, '#047, Fairview Road'),
			   (432715,'SIMUS588', 'Misty', 'Natalie', 'B', 'Vermont', 38, '#518, Brook Lane'),
			   (39001,'SIMUS239', 'Stubot','Stuart', 'P', 'Abbott', 33, '#663, Sunset Avenue'),
			   (235678,'SIMUS177', 'Pearl Waters', 'Ava', 'Q', 'Waters', 27, '#312, Willow Street');

select sl_no, fname from musician_million where sl_no%500=0;
create index ind1 on musician_million(sl_no) on FG5;
drop index musician_million.ind1;


alter table musician_million drop constraint PK__MUSICIAN__14B8FABA2CF56540;

alter table musician_million add constraint pk_mm primary key(sl_no);
alter table musician_million add constraint pk_mm primary key(musician_id);


SELECT * 
  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
 WHERE TABLE_NAME = 'musician_million'

  select * from musician_million;

 select sl_no, count(*) from musician_million group by sl_no having count(*)>1;


--***************************************************************************************************************************************
select addr, count(*) from musician_million group by addr;
create index ind2 on musician_million(addr) on FG5;
drop index musician_million.ind2;


DBCC DROPCLEANBUFFERS
GO

DBCC FREEPROCCACHE
GO

select max(sl_no) from musician_million;
select sum(CONVERT(BIGINT, sl_no)) from musician_million;
--***********************************************************************************************************************

select stage_name 
from musician_million as m 
where exists(select p.musician_id, count(*) 
			 from performs as p 
			 where p.musician_id=m.musician_id 
			 group by p.musician_id 
			 having count(*)=6);

create index ind on performs(musician_id) on FG5;
drop index performs.ind;

--***********************************************************************

select stage_name 
from musician as m 
where exists(select a.musician_id, count(*) 
			 from album as a 
			 where a.musician_id=m.musician_id 
			 group by a.musician_id 
			 having count(*)=2);

create index ind on album(musician_id) on FG5;
drop index album.ind;
