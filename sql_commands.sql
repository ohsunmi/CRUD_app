SELECT * FROM artists WHERE id = 1;

SELECT name FROM artists WHERE id = 1;

INSERT INTO artists (members, soundcloud_followers) VALUES ('2', '10000');

UPDATE artists SET soundcloud_followers = soundcloud_followers + 1 WHERE id = 1;

DELETE FROM artists WHERE id = 1;