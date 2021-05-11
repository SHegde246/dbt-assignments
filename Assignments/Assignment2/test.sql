CREATE TABLE MUSICIAN__
(
	id int,
	musician_id CHAR(8),
	stage_name VARCHAR(20) NOT NULL,
	fname VARCHAR(15) NOT NULL,
	minit CHAR(1),
	lname VARCHAR(15) NOT NULL,
	age INT NOT NULL,
	addr VARCHAR(30),

	PRIMARY KEY(id),
	UNIQUE(stage_name)
) on FG1;
drop table album__
CREATE TABLE ALBUM__
(
	id int,
	album_id CHAR(5),
	a_title VARCHAR(30) NOT NULL,
	type VARCHAR(15) NOT NULL,
	copyright_date DATE NOT NULL CHECK(copyright_date > '1973-04-12'),
	musician_id CHAR(8) NOT NULL,

	PRIMARY KEY(id,album_id)
) on FG2;

INSERT INTO MUSICIAN__ VALUES(1,'SIMUS010', 'Zazu', 'Ryan', 'S', 'Aaron', 24, '#663, Sunset Avenue'),
			   (2,'SIMUS215', 'Reggie Olsen', 'Kyle', 'B', 'Davis', 32, '#312, Willow Street'),
			   (3,'SIMUS003', 'Luna Jade', 'Natalie', 'U', 'Baker', 22, '#663, Sunset Avenue'),
			   (4,'SIMUS096', 'Trixie', 'Mae', 'C', 'Tudgeman', 34, '#232, Maple Drive'),
			   (5,'SIMUS472', 'Sammy J', 'Samuel', NULL, 'Johnson', 43, '#518, Brook Lane'),
			   (6,'SIMUS331', 'Greta', 'Greta', 'G', 'Smith', 54, '#312, Willow Street'),
			   (7,'SIMUS108', 'Benj Benson', 'Benjamin', NULL, 'Turner', 26, '#047, Fairview Road'),
			   (8,'SIMUS588', 'Misty', 'Natalie', NULL, 'Vermont', 38, '#518, Brook Lane'),
			   (9,'SIMUS239', 'Stubot','Stuart', 'P', 'Abbott', 33, '#663, Sunset Avenue'),
			   (10,'SIMUS177', 'Pearl Waters', 'Ava', 'Q', 'Waters', 27, '#312, Willow Street');

INSERT INTO ALBUM__ VALUES(1,'AL003', 'Sleepless Slumber', 'Studio Album', '2010-11-23', 'SIMUS010'),
			(1,'AL006', 'Everyday', 'EP', '2012-04-02', 'SIMUS010'),
			(2,'AL015', 'Old Town', 'Live Album', '2015-10-14', 'SIMUS215'),
			(3,'AL008', 'Evergreen', 'Studio Album', '2018-07-19', 'SIMUS003'),
			(3,'AL007', 'Mystique', 'Studio Album', '2016-03-21', 'SIMUS003'),
			(4,'AL019', 'Freestyle', 'EP', '2007-06-03', 'SIMUS096'),
			(4,'AL016', 'Beats', 'EP', '2008-05-08', 'SIMUS096'),
			(5,'AL012', 'Poet''s Soul', 'Live Album', '1998-12-04', 'SIMUS472'),
			(6,'AL020', 'Orbit', 'Studio Album', '1990-10-22', 'SIMUS331'),
			(7,'AL014', 'The Other Side', 'EP', '2019-02-01', 'SIMUS108'),
			(8,'AL023', 'Foggy Memory', 'Studio Album', '2002-09-30', 'SIMUS588'),
			(9,'AL024', 'Electric Heart', 'Studio Album', '2009-08-31', 'SIMUS239'),
			(10,'AL025', 'Go With It', 'Live Album', '2014-01-29', 'SIMUS177');

create index ind on album__(id);
--************************************************************************
select new.id,new.musician_id,new.stage_name, new.age, new.a_title, new.copyright_date
from
(
select m.id,m.musician_id,m.stage_name,m.age,a.a_title,a.copyright_date
from album__ a, musician__ m
where a.id=m.id
	and m.id between 5 and 10
	and m.age>30
	and a.copyright_date between '1990-01-01' and '2000-12-31'
UNION
select m.id,m.musician_id,m.stage_name,m.age,a.a_title,a.copyright_date
from album__ a, musician__ m
where a.id=m.id
	and m.id between 5 and 10
	and m.age>30
	and a.copyright_date between '2001-01-01' and '2010-12-31'
) new
where
new.id between 5 and 10
and new.age>30
order by new.copyright_date;








select m.id,m.musician_id,m.stage_name,m.age,a.a_title,a.copyright_date
from album__ a, musician__ m
where a.id=m.id
	and m.id between 5 and 10
	and m.age>30
	and a.copyright_date between '1990-01-01' and '2000-12-31'
UNION
select m.id,m.musician_id,m.stage_name,m.age,a.a_title,a.copyright_date
from album__ a, musician__ m
where a.id=m.id
	and m.id between 5 and 10
	and m.age>30
	and a.copyright_date between '2001-01-01' and '2010-12-31'
order by a.copyright_date;
--****************************************************************************
select * from musician_;