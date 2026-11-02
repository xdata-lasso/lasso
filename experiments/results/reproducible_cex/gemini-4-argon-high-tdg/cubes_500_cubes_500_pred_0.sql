-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (101, 'New York', 'Madison Square', 20000, 19500, 12000, 16000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (102, 'London', 'Wembley', 90000, 88000, 50000, 72000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (103, 'Tokyo', 'Budokan', 14000, 13500, 8000, 11000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (201, 'Alice', 'USA', 'Skyfall', '2012', 30, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (202, 'Bob', 'UK', 'Horizon', '2015', 25, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (203, 'Charlie', 'Canada', 'Echoes', '2018', 40, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (204, 'Diana', 'France', 'Lumiere', '2020', 22, 0);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (301, '101', 'Zeta Gala', 'Classical', '2014');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (302, '102', 'Alpha Tour', 'Rock', '2015');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (303, '101', 'Beta Night', 'Jazz', '2016');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (304, '102', 'Empty Show', 'Pop', '2014');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (301, '201');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (301, '202');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (301, '203');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (302, '201');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (303, '202');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (303, '203');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT concert_name, theme, n AS count___ FROM (SELECT LHS.concert_id AS concert_id, LHS.n AS n, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT concert_id, COUNT(*) AS n FROM singer_in_concert GROUP BY concert_id) AS LHS LEFT JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) ORDER BY concert_name, theme NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('Alpha Tour', 'Rock', 1)
('Beta Night', 'Jazz', 2)
('Zeta Gala', 'Classical', 3)
*/

-- Prediction Query
SELECT t2.concert_name, t2.theme, COUNT(*) FROM singer_in_concert AS t1 JOIN concert AS t2 ON t1.concert_id = t2.concert_id GROUP BY t2.concert_id;

/*
Prediction Result:
('Zeta Gala', 'Classical', 3)
('Alpha Tour', 'Rock', 1)
('Beta Night', 'Jazz', 2)
*/