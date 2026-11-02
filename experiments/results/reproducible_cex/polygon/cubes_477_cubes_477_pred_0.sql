-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (9, '14', '15', NULL, 16, 17, 18);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (8, '906', '906', 906, 906, 906, 906);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (11, '906', '906', '906', '906', 906, 1);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (10, '906', '906', '906', '906', 906, 1);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (13, 8, '906', '906', '906');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (12, 8, '906', '906', '906');
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (12, '11');
INSERT INTO "singer_in_concert" ("concert_id", "singer_id") VALUES (12, '10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT meancapacity AS avg_capacity_, MAX(capacity) OVER () AS max_capacity_ FROM (SELECT stadium_id, LOCATION, name, capacity, highest, lowest, average, AVG(capacity) OVER () AS meancapacity FROM stadium) ORDER BY avg_capacity_, max_capacity_ NULLS LAST;

/*
Gold Result:
(906.0, 906)
*/

-- Prediction Query
SELECT AVG(capacity), MAX(capacity) FROM stadium;

/*
Prediction Result:
(906.0, 906)
*/