-- Schema DDL
CREATE TABLE "stadium" ("Stadium_ID" INTEGER PRIMARY KEY, "Location" TEXT, "Name" TEXT, "Capacity" INTEGER, "Highest" INTEGER, "Lowest" INTEGER, "Average" INTEGER);

CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Song_Name" TEXT, "Song_release_year" TEXT, "Age" INTEGER, "Is_male" INTEGER);

CREATE TABLE "concert" ("concert_ID" INTEGER PRIMARY KEY, "Stadium_ID" TEXT, "concert_Name" TEXT, "Theme" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("Stadium_ID"));

CREATE TABLE "singer_in_concert" ("concert_ID" INTEGER, "Singer_ID" TEXT, PRIMARY KEY ("concert_ID", "Singer_ID"), FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"), FOREIGN KEY ("concert_ID") REFERENCES "concert" ("concert_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO stadium (Stadium_ID, Location, Name, Capacity, Highest, Lowest, Average) VALUES (1, 'New York', 'Metro Arena', 50000, 48000, 12000, 30000);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (10, 'Alice', 'USA', 'First Track', '1995', 45, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (20, 'Zara', 'UK', 'Middle Track', '2005', 30, 0);
INSERT INTO singer (Singer_ID, Name, Country, Song_Name, Song_release_year, Age, Is_male) VALUES (30, 'Bob', 'France', 'Last Track', '2015', 19, 1);
INSERT INTO concert (concert_ID, Stadium_ID, concert_Name, Theme, Year) VALUES (100, '1', 'Summer Fest', 'Pop', '2020');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (100, '10');
INSERT INTO singer_in_concert (concert_ID, Singer_ID) VALUES (100, '30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT song_name, song_release_year FROM (SELECT * FROM (SELECT * FROM singer ORDER BY name DESC, singer.singer_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Middle Track', '2005')
*/

-- Prediction Query
SELECT song_name, song_release_year FROM singer ORDER BY age, singer.singer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Last Track', '2015')
*/