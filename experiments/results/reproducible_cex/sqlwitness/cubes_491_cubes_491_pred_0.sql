-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (stadium_id, location, name, capacity, highest, lowest, average) VALUES (1, 'default2', 'default2', 1, 0, 1, 0), (0, 'default1', 'default2', NULL, 0, 1, 0), (2, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO concert (concert_id, stadium_id, concert_name, theme, year) VALUES (0, 2, 'default2', 'default2', NULL), (1, 1, NULL, NULL, 'default1'), (2, 0, NULL, 'default1', 'default2'), (3, 0, 'default2', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.stadium_id AS stadium_id, LHS.location AS LOCATION, LHS.name AS name, LHS.capacity AS capacity, LHS.highest AS highest, LHS.lowest AS lowest, LHS.average AS average, RHS.n AS n FROM stadium AS LHS INNER JOIN (SELECT stadium_id, COUNT(*) AS n FROM concert GROUP BY stadium_id) AS RHS ON (LHS.stadium_id = RHS.stadium_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('default2', 1)
('default2', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id GROUP BY T1.stadium_id;

/*
Prediction Result:
('default2', 2)
('default2', 1)
(None, 1)
*/