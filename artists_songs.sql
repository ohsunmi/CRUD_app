CREATE DATABASE crud_app;

CREATE TABLE artists (
	id serial primary key,
	name varchar(50) NOT NULL,
	genre varchar(30),
	num_members smallint default 1,
	origin varchar(30)
);

CREATE TABLE songs (
	id serial primary key,
	name varchar(50) NOT NULL,
	on_itunes boolean,
	soundcloud_likes integer,
	artist_id serial,
	FOREIGN KEY (artist_id)
		REFERENCES artists(id)
);