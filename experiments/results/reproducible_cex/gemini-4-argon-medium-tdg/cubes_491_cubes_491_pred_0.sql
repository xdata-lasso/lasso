-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT JOIN (stadium with 0 concerts), basic aggregation (1 vs multiple concerts), and basic ordering.
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'London', 'Wembley', 90000, 90000, 50000, 70000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'Manchester', 'Old Trafford', 74000, 74000, 40000, 60000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (3, 'Liverpool', 'Anfield', 53000, 53000, 30000, 45000);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (101, '1', 'Live Aid', 'Charity', '1985');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (102, '1', 'Summer Fest', 'Rock', '2020');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (103, '2', 'Pop Night', 'Pop', '2021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.stadium_id AS stadium_id, LHS.location AS LOCATION, LHS.name AS name, LHS.capacity AS capacity, LHS.highest AS highest, LHS.lowest AS lowest, LHS.average AS average, RHS.n AS n FROM stadium AS LHS INNER JOIN (SELECT stadium_id, COUNT(*) AS n FROM concert GROUP BY stadium_id) AS RHS ON (LHS.stadium_id = RHS.stadium_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Old Trafford', 1)
('Wembley', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id GROUP BY T1.stadium_id;

/*
Prediction Result:
('Wembley', 2)
('Old Trafford', 1)
*/