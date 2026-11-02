-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'New York', 'Metro Arena', 20000, 19500, 12000, 16000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'London', 'Royal Dome', 15000, 14800, 9000, 12500);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Zoe', 'USA', 'Starlight', '2020', 25, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Bob', 'UK', 'Thunder', '2018', 32, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (3, 'Alice', 'Canada', 'Horizon', '2021', 28, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (4, 'David', 'Australia', 'Ocean', '2019', 40, 1);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (10, '1', 'Summer Fest', 'Pop', '2022');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (20, '1', 'Winter Gala', 'Rock', '2022');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (30, '2', 'Spring Jam', 'Jazz', '2023');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (40, '2', 'Autumn Acoustic', 'Folk', '2023');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (10, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (10, '2');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (20, '2');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (30, '2');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (10, '3');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (20, '3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.n AS n FROM singer AS LHS INNER JOIN (SELECT singer_id, COUNT(*) AS n FROM singer_in_concert GROUP BY singer_id) AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 2)
('Bob', 3)
('Zoe', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id GROUP BY T2.singer_id;

/*
Prediction Result:
('Zoe', 1)
('Bob', 3)
('Alice', 2)
*/