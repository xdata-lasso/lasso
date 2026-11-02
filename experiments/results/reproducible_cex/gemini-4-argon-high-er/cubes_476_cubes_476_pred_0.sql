-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (1, 'Alice', 'USA', 'Song A', '2020', 20, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (2, 'Bob', 'UK', 'Song B', '2021', 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, country, age FROM singer ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice', 'USA', 20)
('Bob', 'UK', 30)
*/

-- Prediction Query
SELECT name, country, age FROM singer ORDER BY age DESC, singer.singer_id NULLS LAST;

/*
Prediction Result:
('Bob', 'UK', 30)
('Alice', 'USA', 20)
*/