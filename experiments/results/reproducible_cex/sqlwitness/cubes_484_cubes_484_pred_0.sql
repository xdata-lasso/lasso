-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (1, 'default1', 'default1', NULL, NULL, 1, 0), (19, 'default1', 'default1', NULL, NULL, NULL, 1), (20, NULL, NULL, NULL, 'default2', 19, NULL), (21, NULL, 'default2', 'default2', 'default1', 20, NULL), (0, NULL, 'default2', 'default1', 'default1', 20, NULL), (2, 'default1', 'default1', NULL, 'default1', 21, NULL), (3, NULL, 'default1', NULL, 'default2', 20, NULL), (4, NULL, 'default2', 'default1', 'default2', 0, 1), (5, NULL, 'default2', NULL, NULL, NULL, 1), (6, 'default2', NULL, 'default2', NULL, 20, NULL), (7, 'default2', NULL, NULL, 'default2', 1, 0), (8, 'default2', 'default2', 'default1', NULL, 1, 1), (9, 'default1', 'default1', NULL, 'default1', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age >= 20) ORDER BY country;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT country FROM singer WHERE age > 20;

/*
Prediction Result:
('default1',)
*/