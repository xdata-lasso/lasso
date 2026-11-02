-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: singer --
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (2, '5k5swwqcgs', 'sin_57fae6', '9n8', '4', 20, -734455130);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (3, '4h', 'sin_57fae6', 'ia2yp', 'uzhsrwbbp6lu', 20, 1019800248);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (4, 'dlttil', 'n', 'rmdp', 'siie', 19, -45536098);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (5, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', NULL, 283598170);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (6, 'zbuo4nrq', NULL, 'rofqyp5s5b', 'p', 20, 882961052);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483643, '2eutliqa11r', 'C', 'ytoo3o9', 'l7', 1178636309, -1390245819);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483642, 'x14ji7zwau2d', 'A', 'yrq13p', 'u78d99r', -1362461264, -904834265);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483641, 'b4yp5qi', 'Q', 'rkf9vqx5', 'pz0f8jegd', -283454505, 233994589);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483640, 'j4hwbd', 'A', 'lph2gn', 'q', -664193365, -1070063173);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483639, 'x5hncprjtu0', 'O', 'z', '9fjgq8n2f', -1056308489, -1454058168);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483638, 'bilyrkn', 'A', '6vck6ah0f8js', 'wlq7xb', 602161869, 1350414441);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483637, 'a7ryfd', '_', 'z16ni', 'jai', 1746373317, 1360271423);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (-2147483636, 'ogrgjd8y', 'A', 't1afgog', 'itsj3', -491938169, -106471771);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age >= 20) ORDER BY country;

/*
Gold Result:
(None,)
('A',)
('C',)
('_',)
('sin_57fae6',)
*/

-- Prediction Query
SELECT DISTINCT country FROM singer WHERE age > 20;

/*
Prediction Result:
('C',)
('A',)
('_',)
*/