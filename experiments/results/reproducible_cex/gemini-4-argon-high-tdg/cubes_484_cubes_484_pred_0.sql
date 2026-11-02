-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'London', 'Wembley', 90000, 89000, 10000, 50000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Alice', 'USA', 'Alpha', '1990', 20, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Bob', 'UK', 'Beta', '2000', 25, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (3, 'Charlie', 'UK', 'Gamma', '2010', 30, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (4, 'David', 'France', 'Delta', '2015', 19, 1);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (5, 'Eve', 'Canada', 'Epsilon', '2020', 21, 0);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (1, '1', 'Live Aid', 'Rock', '2022');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (1, '2');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (1, '4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM singer WHERE (age >= 20) ORDER BY country;

/*
Gold Result:
('Canada',)
('UK',)
('USA',)
*/

-- Prediction Query
SELECT DISTINCT country FROM singer WHERE age > 20;

/*
Prediction Result:
('UK',)
('Canada',)
*/