-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1007, '65423 Garcia Light
West Melanieview, AS 06196', 'Kimberly Dudley', 1008, 1009, 1010, 1011);
INSERT INTO "stadium" ("stadium_id", "location", "name", "capacity", "highest", "lowest", "average") VALUES (1013, NULL, 'Holly Wood', 1014, 1015, 1016, 1017);
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1012, 1007, 'Juan Calderon', 'present', 'value');
INSERT INTO "concert" ("concert_id", "stadium_id", "concert_name", "theme", "year") VALUES (1018, 1013, 'Derek Zuniga', 'raise', 'away');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.stadium_id AS stadium_id, LHS.location AS LOCATION, LHS.name AS name, LHS.capacity AS capacity, LHS.highest AS highest, LHS.lowest AS lowest, LHS.average AS average, RHS.n AS n FROM stadium AS LHS INNER JOIN (SELECT stadium_id, COUNT(*) AS n FROM concert GROUP BY stadium_id) AS RHS ON (LHS.stadium_id = RHS.stadium_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Holly Wood', 1)
('Kimberly Dudley', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id GROUP BY T1.stadium_id;

/*
Prediction Result:
('Kimberly Dudley', 1)
('Holly Wood', 1)
*/