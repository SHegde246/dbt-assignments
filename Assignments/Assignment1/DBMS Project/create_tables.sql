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
);

CREATE TABLE INSTRUMENT
(
	instrument_id CHAR(6),
	i_name VARCHAR(20) NOT NULL,
	i_type VARCHAR(10) NOT NULL,
	
	PRIMARY KEY(instrument_id)
);

CREATE TABLE ALBUM
(
	album_id CHAR(5),
	a_title VARCHAR(30) NOT NULL,
	type VARCHAR(15) NOT NULL,
	copyright_date DATE NOT NULL CHECK(copyright_date > '1973-04-12'),
	musician_id CHAR(8) NOT NULL,

	PRIMARY KEY(album_id)
);

CREATE TABLE SONG
(
	song_id CHAR(5),
	s_title VARCHAR(30) NOT NULL,
	album_id CHAR(5) NOT NULL,
	
	PRIMARY KEY(song_id)
);

CREATE TABLE HOUSE
(
	addr VARCHAR(30),
	landmark VARCHAR(60) NOT NULL,
	phone_no CHAR(10) NOT NULL,

	PRIMARY KEY(addr),
	UNIQUE(phone_no)
);

CREATE TABLE PERFORMS
(
	musician_id CHAR(8),
	song_id CHAR(5),

	PRIMARY KEY(musician_id, song_id)
);

CREATE TABLE PLAYS
(
	musician_id CHAR(8),
	instrument_id CHAR(6),

	PRIMARY KEY(musician_id, instrument_id)
);

CREATE TABLE AUTHOR
(
	fn VARCHAR(15),
	ln VARCHAR(15),
	song_id CHAR(5),

	PRIMARY KEY(fn, ln, song_id)
);



ALTER TABLE MUSICIAN
ADD FOREIGN KEY(addr) REFERENCES HOUSE(addr)
			ON DELETE SET NULL   ON UPDATE CASCADE;

ALTER TABLE ALBUM
ADD FOREIGN KEY(musician_id) REFERENCES MUSICIAN(musician_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE SONG
ADD FOREIGN KEY(album_id) REFERENCES ALBUM(album_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE PERFORMS
ADD FOREIGN KEY(musician_id) REFERENCES MUSICIAN(musician_id)
				ON DELETE CASCADE   ON UPDATE CASCADE,
ADD FOREIGN KEY(song_id) REFERENCES SONG(song_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE PLAYS
ADD FOREIGN KEY(musician_id) REFERENCES MUSICIAN(musician_id)
				ON DELETE CASCADE   ON UPDATE CASCADE,
ADD FOREIGN KEY(instrument_id) REFERENCES INSTRUMENT(instrument_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;

ALTER TABLE AUTHOR
ADD FOREIGN KEY(song_id) REFERENCES SONG(song_id)
				ON DELETE CASCADE   ON UPDATE CASCADE;
	