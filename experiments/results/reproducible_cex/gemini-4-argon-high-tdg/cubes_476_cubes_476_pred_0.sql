-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'New York', 'Madison Square', 20000, 19500, 10000, 15000);
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (2, 'London', 'Wembley', 90000, 88000, 40000, 65000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Charlie', 'UK', 'Yesterday', '1995', 28, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Alice', 'USA', 'Skyfall', '2012', 35, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (3, 'Bob', 'Canada', 'Horizon', '2005', 22, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (4, 'Diana', 'Australia', 'Ocean', '2020', 41, 0);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (10, '1', 'Rock Night', 'Rock', '2021');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (20, '2', 'Pop Fest', 'Pop', '2022');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (10, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (20, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (10, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country, age FROM singer ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice', 'USA', 35)
('Bob', 'Canada', 22)
('Charlie', 'UK', 28)
('Diana', 'Australia', 41)
*/

-- Prediction Query
SELECT name, country, age FROM singer ORDER BY age DESC, singer.singer_id NULLS LAST;

/*
Prediction Result:
('Diana', 'Australia', 41)
('Alice', 'USA', 35)
('Charlie', 'UK', 28)
('Bob', 'Canada', 22)
*/