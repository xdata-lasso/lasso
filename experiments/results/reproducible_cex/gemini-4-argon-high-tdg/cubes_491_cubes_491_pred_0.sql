-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (10, 'New York', 'Zebra Dome', 50000, 48000, 12000, 30000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (20, 'London', 'Alpha Arena', 60000, 59000, 20000, 45000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (30, 'Tokyo', 'Metro Field', 40000, 35000, 10000, 25000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (40, 'Paris', 'Empty Ground', 30000, 25000, 5000, 15000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Alice', 'USA', 'Sunrise', '2020', 25, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Bob', 'UK', 'Horizon', '2019', 30, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (3, 'Charlie', 'Japan', 'Neon', '2021', 22, 1);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (101, '10', 'Rock Night', 'Rock', '2022');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (102, '20', 'Pop Fest 1', 'Pop', '2021');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (103, '20', 'Pop Fest 2', 'Pop', '2022');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (104, '20', 'Jazz Evening', 'Jazz', '2023');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (105, '30', 'Summer Jam', 'Indie', '2020');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (106, '30', 'Winter Gala', 'Classical', '2021');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (101, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (101, '2');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (101, '3');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (102, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.stadium_id AS stadium_id, LHS.location AS LOCATION, LHS.name AS name, LHS.capacity AS capacity, LHS.highest AS highest, LHS.lowest AS lowest, LHS.average AS average, RHS.n AS n FROM stadium AS LHS INNER JOIN (SELECT stadium_id, COUNT(*) AS n FROM concert GROUP BY stadium_id) AS RHS ON (LHS.stadium_id = RHS.stadium_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alpha Arena', 3)
('Metro Field', 2)
('Zebra Dome', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM concert AS T1 JOIN stadium AS T2 ON T1.stadium_id = T2.stadium_id GROUP BY T1.stadium_id;

/*
Prediction Result:
('Zebra Dome', 1)
('Alpha Arena', 3)
('Metro Field', 2)
*/