-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Bob', 1985.0, 12.5, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1990.0, 45.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, NULL, 1978.0, 5.2, 'Canada');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (4, 'Charlie', 2000.0, 1.0, 'USA');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (10, 1, 'Echo', 500000.0, 2.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (20, 2, 'Echo', 750000.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (30, 3, 'Echo', 120000.0, 15.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (40, 1, 'Beta', 300000.0, 5.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (50, NULL, 'Alpha', 900000.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, RHS.song_id AS song_id, RHS.title AS title, RHS.sales AS sales, RHS.highest_position AS highest_position FROM singer AS LHS INNER JOIN song AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY title, name NULLS LAST;

/*
Gold Result:
('Beta', 'Bob')
('Echo', 'Alice')
('Echo', 'Bob')
('Echo', None)
*/

-- Prediction Query
SELECT T2.Title, T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID;

/*
Prediction Result:
('Echo', 'Bob')
('Echo', 'Alice')
('Echo', None)
('Beta', 'Bob')
*/