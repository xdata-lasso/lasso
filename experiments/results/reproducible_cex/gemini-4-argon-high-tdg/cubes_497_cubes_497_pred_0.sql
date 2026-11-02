-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'Austin', 'Zenith Arena', 50000, 48000, 30000, 40000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'Boston', 'Apex Dome', 60000, 59000, 45000, 52000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (3, 'Chicago', 'Metro Field', 45000, 44000, 20000, 35000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (4, 'Denver', 'Crest Bowl', 70000, 68000, 50000, 61000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (5, 'Miami', 'Echo Park', 55000, 53000, 32000, 44000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (6, 'Seattle', 'Bravo Stadium', 65000, 64000, 40000, 55000);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (101, '2', 'Summer Vibes', 'Pop', '2015');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (102, '2', 'Autumn Beats', 'Rock', '2016');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (103, '3', 'Winter Gala', 'Classical', '2014');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (104, '4', 'Retro Night', 'Disco', '2012');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (105, '5', 'Early Fest', 'Indie', '2013');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (106, '5', 'Future Sound', 'EDM', '2017');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (107, '6', 'Boundary Live', 'Jazz', '2014');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (108, '6', 'Next Gen', 'Pop', '2015');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM stadium AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM concert WHERE (YEAR <= 2014)) AS RHS WHERE (LHS.stadium_id = RHS.stadium_id))) ORDER BY name;

/*
Gold Result:
('Apex Dome',)
('Zenith Arena',)
*/

-- Prediction Query
SELECT name FROM stadium EXCEPT SELECT T2.name FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id WHERE T1.year = 2014;

/*
Prediction Result:
('Apex Dome',)
('Crest Bowl',)
('Echo Park',)
('Zenith Arena',)
*/