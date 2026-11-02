-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: singer --
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1, 'sin_69e1b4', 'sin_fd9496', 'sin_b67549', 'sin_38abd4', 1, 1);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483647, 'sin_80f6c7', 'sin_982cae', 'sin_9aff5a', 'sin_980ed3', 1, 1);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-1, 'A', '5k5swwqcgs', '9n8', '4', -734455130, 1744686505);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (0, 'A', 'hria2ypu', 'hsrwbbp', 'luhvdltti', -1364429300, -1257178728);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483644, 'mdpos', 'ie5', 'q_1_23d3e4', 'q_1_784fc2', -1209887326, -1399556171);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483643, 'a9000t5c4eci', 'gce376nium52', 'q_1_23d3e4', 'q_1_784fc2', -443340271, 757448742);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song_name, song_release_year FROM (SELECT * FROM (SELECT * FROM singer ORDER BY name DESC, singer.singer_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('sin_9aff5a', 'sin_980ed3')
*/

-- Prediction Query
SELECT song_name, song_release_year FROM singer ORDER BY age, singer.singer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('hsrwbbp', 'luhvdltti')
*/