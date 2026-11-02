-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (1, NULL, 'default1', 'default2', NULL, 0, 1), (0, NULL, 'default1', 'default2', NULL, 1, 0), (2, 'default2', 'default2', 'default1', NULL, NULL, 0), (3, NULL, NULL, 'default1', NULL, NULL, NULL), (4, NULL, 'default1', 'default2', 'default1', NULL, 0), (5, NULL, 'default2', NULL, 'default2', NULL, 1), (6, 'default2', NULL, 'default2', NULL, NULL, 1);
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (0, 'default2', NULL, 0, NULL, NULL, 1), (1, NULL, 'default2', NULL, 0, 0, 1), (2, 'default1', NULL, NULL, NULL, NULL, 0), (3, 'default2', NULL, 1, 1, 1, 1), (4, NULL, 'default1', NULL, 0, NULL, NULL), (5, NULL, 'default1', 1, 1, 0, 0);
INSERT INTO concert (concert_id, stadium_id, concert_name, theme, year) VALUES (1, 3, NULL, 'default2', 'default1'), (0, 4, 'default1', NULL, 'default1'), (2, NULL, 'default1', 'default1', NULL), (3, 3, 'default2', NULL, NULL), (4, 0, 'default1', 'default1', NULL), (5, 5, 'default1', 'default1', NULL), (6, 4, 'default1', NULL, NULL), (7, 4, 'default2', 'default2', NULL);
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (2, 1), (7, 6), (2, 0), (3, 1), (3, 4), (6, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.n AS n FROM singer AS LHS INNER JOIN (SELECT singer_id, COUNT(*) AS n FROM singer_in_concert GROUP BY singer_id) AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
(None, 2)
('default2', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id GROUP BY T2.singer_id;

/*
Prediction Result:
(None, 1)
(None, 2)
(None, 1)
('default2', 2)
*/