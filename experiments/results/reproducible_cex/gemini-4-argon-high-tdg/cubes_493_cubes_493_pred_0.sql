-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (10, 'London', 'Wembley', 90000, 88000, 50000, 72000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (20, 'Madrid', 'Bernabeu', 81000, 80000, 45000, 65000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Zara', 'UK', 'Skyfall', '2012', 28, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Mona', 'France', 'Etoile', '2015', 34, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (3, 'Alice', 'USA', 'Sunrise', '2010', 22, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (4, 'David', 'Germany', 'Echo', '2014', 41, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (5, 'Elena', 'Spain', 'Fuego', '2014', 29, 0);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (101, '10', 'Summer Fest', 'Rock', '2014');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (102, '20', 'Winter Gala', 'Pop', '2014');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (103, '10', 'Retro Night', 'Disco', '2013');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (104, '20', 'Future Sound', 'Synth', '2015');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (101, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (102, '2');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (101, '3');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (103, '4');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (104, '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, LHS.concert_id AS concert_id, LHS.concert_name AS concert_name, LHS.theme AS theme, LHS.stadium_id AS stadium_id, LHS.year AS YEAR FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, LHS.concert_id AS concert_id, RHS.concert_name AS concert_name, RHS.theme AS theme, RHS.stadium_id AS stadium_id, RHS.year AS YEAR FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.country AS country, LHS.song_name AS song_name, LHS.song_release_year AS song_release_year, LHS.age AS age, LHS.is_male AS is_male, RHS.concert_id AS concert_id FROM singer AS LHS INNER JOIN singer_in_concert AS RHS ON (LHS.singer_id = RHS.singer_id)) AS LHS INNER JOIN concert AS RHS ON (LHS.concert_id = RHS.concert_id)) AS LHS INNER JOIN (SELECT * FROM concert WHERE (YEAR = 2014)) AS RHS ON (LHS.concert_id = RHS.concert_id AND LHS.concert_name = RHS.concert_name AND LHS.theme = RHS.theme AND LHS.stadium_id = RHS.stadium_id AND LHS.year = RHS.year)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Mona',)
('Zara',)
*/

-- Prediction Query
SELECT T2.name FROM singer_in_concert AS T1 JOIN singer AS T2 ON T1.singer_id = T2.singer_id JOIN concert AS T3 ON T1.concert_id = T3.concert_id WHERE T3.year = 2014;

/*
Prediction Result:
('Zara',)
('Mona',)
('Alice',)
*/