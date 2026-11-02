-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (singer_id, name, country, song_name, song_release_year, age, is_male) VALUES (0, 'default1', 'default2', 'default2', NULL, NULL, 1), (1, 'default2', 'default2', 'default1', 'default2', 0, 1), (2, NULL, NULL, 'default2', NULL, 1, 0), (3, 'default2', 'default2', 'default2', NULL, 0, 1), (4, NULL, NULL, NULL, 'default1', 0, 0);
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (0, NULL, 'default2', 1, NULL, 1, NULL), (1, NULL, NULL, 1, 0, NULL, 1);
INSERT INTO concert (concert_id, stadium_id, concert_name, theme, year) VALUES (1, 0, 'default1', 'default2', NULL), (0, 1, 'default1', 'default2', 'default1'), (2, NULL, 'default1', 'default2', NULL), (3, NULL, 'default2', 'default1', 'default1'), (4, NULL, 'default1', 'default1', 'default2'), (5, 1, 'default1', 'default1', 'default2');
INSERT INTO singer_in_concert (concert_id, singer_id) VALUES (5, 2), (5, 4), (4, 3), (2, 4), (5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT concert_name, theme, n AS count___ FROM (SELECT LHS.concert_id AS concert_id, LHS.n AS n, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT concert_id, COUNT(*) AS n FROM singer_in_concert GROUP BY concert_id) AS LHS LEFT JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) ORDER BY concert_name, theme NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('default1', 'default1', 1)
('default1', 'default1', 3)
('default1', 'default2', 1)
*/

-- Prediction Query
SELECT t2.concert_name, t2.theme, COUNT(*) FROM singer_in_concert AS t1 JOIN concert AS t2 ON t1.concert_id = t2.concert_id GROUP BY t2.concert_id;

/*
Prediction Result:
('default1', 'default2', 1)
('default1', 'default1', 1)
('default1', 'default1', 3)
*/