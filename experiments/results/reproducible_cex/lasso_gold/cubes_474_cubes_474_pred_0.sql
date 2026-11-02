-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1001, 'Allison Hill', 'Uganda', 'Javier Johnson', 'decide', 40, 1003);
INSERT INTO "singer" ("singer_id", "name", "country", "song_name", "song_release_year", "age", "is_male") VALUES (1002, 'Noah Rhodes', 'Mayotte', 'Jonathan Johnson', 'sense', 0, 1018.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age = 40 OR age < 30) ORDER BY country;

/*
Gold Result:
('Mayotte',)
('Uganda',)
*/

-- Prediction Query
SELECT country FROM singer WHERE age > 40 INTERSECT SELECT country FROM singer WHERE age < 30;

/*
Prediction Result:
*/