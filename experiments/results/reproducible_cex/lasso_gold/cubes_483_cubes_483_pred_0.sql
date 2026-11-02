-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1001, 'Allison Hill', 'Anguilla', 'Kimberly Robinson', 'best', 1005, 1009);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1002, 'Noah Rhodes', 'Monaco', 'Rhonda Smith', 'husband', 1018.0, 1024.0);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1003, 'Angie Henderson', 'Congo', 'Melissa Peterson', 'bill', 1031.0, 1039.0);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1004, 'Daniel Wagner', 'Saint Barthelemy', 'Tyler Rogers', 'her', 1044.0, 1054.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song_name, song_release_year FROM (SELECT * FROM (SELECT * FROM singer ORDER BY name DESC, singer.singer_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Rhonda Smith', 'husband')
*/

-- Prediction Query
SELECT song_name, song_release_year FROM singer ORDER BY age, singer.singer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Kimberly Robinson', 'best')
*/