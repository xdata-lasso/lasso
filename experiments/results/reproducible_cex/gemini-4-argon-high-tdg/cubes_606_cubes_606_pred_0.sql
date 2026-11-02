-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Zara', 1948.0, 50.0, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1949.0, 10.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, 'Monad', 1948.5, 30.0, 'Canada');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (4, 'Bob', 1947.9, 20.0, 'France');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (5, 'Charlie', 1949.1, 40.0, 'Germany');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (6, 'David', 1947.0, 60.0, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (7, 'Eve', 1950.0, 15.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (8, 'Frank', NULL, 25.0, 'Canada');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (101, 1, 'Song A', 500000.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (102, 1, 'Song B', 300000.0, 5.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (103, 4, 'Song C', 200000.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM singer WHERE (birth_year >= 1948.0 AND birth_year <= 1949.0) ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Monad',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Birth_Year = 1948 OR Birth_Year = 1949;

/*
Prediction Result:
('Zara',)
('Alice',)
*/