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