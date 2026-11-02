-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: singer --
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (2, '5k5swwqcgs', 'sin_4bad2f', '9n8', '4', 0, -734455130);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (3, '4h', 'sin_4bad2f', 'ia2yp', 'uzhsrwbbp6lu', 0, 1019800248);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (4, 'dlttil', 'n', 'rmdp', 'siie', 40, -45536098);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 30, -1865039888);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (6, 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', NULL, 1236688122);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (7, 'dpos', 'ie5', 'nw6klf', 'a9000t5c4eci', NULL, 1149850321);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (8, 'e', '76nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', NULL, 743312762);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (9, 'eutliqa11r', 'ytoo3o9', 'l7', 'klex14ji', NULL, -453362185);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (10, 'au2dwyrq13', 'yu78', '9', 'rljsl0b4y', NULL, -1116181514);

INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (11, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 'j4hwbdvlph', NULL, -261132974);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age = 40 OR age < 30) ORDER BY country;

/*
Gold Result:
('n',)
('sin_4bad2f',)
*/

-- Prediction Query
SELECT country FROM singer WHERE age > 40 INTERSECT SELECT country FROM singer WHERE age < 30;

/*
Prediction Result:
*/