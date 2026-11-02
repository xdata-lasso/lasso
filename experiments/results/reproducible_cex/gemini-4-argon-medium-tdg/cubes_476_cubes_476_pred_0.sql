-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'New York', 'MetLife', 82500, 80000, 50000, 65000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (3, 'Charlie', 'UK', 'Song C', '2020', 30, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Alice', 'USA', 'Song A', '2018', 25, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Bob', 'Canada', 'Song B', '2019', 40, 1);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (10, '1', 'Summer Fest', 'Rock', '2021');
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (20, '1', 'Winter Gala', 'Pop', '2022');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (10, '1');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (20, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country, age FROM singer ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice', 'USA', 25)
('Bob', 'Canada', 40)
('Charlie', 'UK', 30)
*/

-- Prediction Query
SELECT name, country, age FROM singer ORDER BY age DESC, singer.singer_id NULLS LAST;

/*
Prediction Result:
('Bob', 'Canada', 40)
('Charlie', 'UK', 30)
('Alice', 'USA', 25)
*/