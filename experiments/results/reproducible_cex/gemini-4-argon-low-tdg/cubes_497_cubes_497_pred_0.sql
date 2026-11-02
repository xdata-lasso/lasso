-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'Loc1', 'Zebra Arena', 1000, 100, 10, 50);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'Loc2', 'Beta Bowl', 2000, 200, 20, 60);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (3, 'Loc3', 'Gamma Ground', 3000, 300, 30, 70);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (4, 'Loc4', 'Delta Dome', 4000, 400, 40, 80);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (5, 'Loc5', 'Alpha Field', 5000, 500, 50, 90);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (6, 'Loc6', 'Alpha Field', 6000, 600, 60, 100);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (101, '2', 'C1', 'T1', '2014');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (102, '3', 'C2', 'T2', '2015');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (103, '3', 'C3', 'T3', '2016');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (104, '4', 'C4', 'T4', '2013');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (105, '4', 'C5', 'T5', '2015');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM concert WHERE (YEAR <= 2014)) AS RHS WHERE (LHS.stadium_id = RHS.stadium_id))) ORDER BY name;

/*
Gold Result:
('Alpha Field',)
('Alpha Field',)
('Gamma Ground',)
('Zebra Arena',)
*/

-- Prediction Query
SELECT name FROM stadium EXCEPT SELECT T2.name FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2014;

/*
Prediction Result:
('Alpha Field',)
('Delta Dome',)
('Gamma Ground',)
('Zebra Arena',)
*/