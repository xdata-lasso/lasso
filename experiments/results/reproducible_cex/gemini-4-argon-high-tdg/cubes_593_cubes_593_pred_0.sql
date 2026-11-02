-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Alice', 1995.0, 50.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Zara', 1980.0, 90.0, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, 'Bob', 1990.0, 20.0, 'France');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (4, 'Charlie', 1990.0, 25.0, 'France');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (10, 'Adam', 1980.0, 10.0, 'Canada');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (101, 1, 'Sunrise', 500000.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (102, 1, 'Sunset', 250000.0, 5.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (103, 3, 'Horizon', 100000.0, 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_year, citizenship FROM singer ORDER BY birth_year, singer.singer_id NULLS LAST;

/*
Gold Result:
(1980.0, 'USA')
(1980.0, 'Canada')
(1990.0, 'France')
(1990.0, 'France')
(1995.0, 'UK')
*/

-- Prediction Query
SELECT Birth_Year, Citizenship FROM singer;

/*
Prediction Result:
(1995.0, 'UK')
(1980.0, 'USA')
(1990.0, 'France')
(1990.0, 'France')
(1980.0, 'Canada')
*/