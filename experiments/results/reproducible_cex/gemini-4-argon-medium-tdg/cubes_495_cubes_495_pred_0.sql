-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (100, 'NY', 'Arena1', 100, 1, 10, 50);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (200, 'LA', 'Arena2', 100, 1, 20, 60);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (300, 'SF', 'Arena3', 100, 2, 30, 70);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (400, 'TX', 'Arena4', 200, 3, 40, 80);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (1, '100', 'RockFest', 'Rock', '2020');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (2, '100', 'PopFest', 'Pop', '2021');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (3, '200', 'JazzFest', 'Jazz', '2022');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT stadium_id) AS n_distinct FROM (SELECT concert_id, concert_name, theme, stadium_id, YEAR, stadium_id_other, LOCATION, name, lowest, average, highest, stadium_id AS capacity FROM (SELECT concert_id, concert_name, theme, stadium_id, YEAR, stadium_id_other, LOCATION, name, lowest, average, concert_id AS highest FROM (SELECT LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR, RHS.stadium_id AS stadium_id_other, RHS.location AS LOCATION, RHS.name AS name, RHS.lowest AS lowest, RHS.average AS average FROM concert AS LHS INNER JOIN stadium AS RHS ON (LHS.concert_id = RHS.highest AND LHS.stadium_id = RHS.capacity))))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM concert WHERE stadium_id = (SELECT stadium_id FROM stadium ORDER BY capacity DESC, stadium.stadium_id NULLS LAST LIMIT 1);

/*
Prediction Result:
(0,)
*/