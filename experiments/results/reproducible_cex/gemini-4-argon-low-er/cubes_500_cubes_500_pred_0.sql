-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'Loc', 'Stad', 1000, 100, 10, 50);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Singer1', 'USA', 'Song1', '2020', 25, 1);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (1, '1', 'Concert B', 'Theme B', '2020');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (2, '1', 'Concert A', 'Theme A', '2020');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (1, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (2, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT concert_name, theme, n AS count___ FROM (SELECT LHS.concert_id AS concert_id, LHS.n AS n, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT concert_id, COUNT(*) AS n FROM singer_in_concert GROUP BY concert_id) AS LHS LEFT JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) ORDER BY concert_name, theme NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('Concert A', 'Theme A', 1)
('Concert B', 'Theme B', 1)
*/

-- Prediction Query
SELECT t2.concert_name, t2.theme, COUNT(*) FROM singer_in_concert AS t1 JOIN concert AS t2 ON t1.concert_id = t2.concert_id GROUP BY t2.concert_id;

/*
Prediction Result:
('Concert B', 'Theme B', 1)
('Concert A', 'Theme A', 1)
*/