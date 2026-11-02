-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Charlie', 1985.0, 10.5, 'US');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1990.0, 20.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, NULL, 1975.0, 5.0, 'CA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (4, 'Bob', 1980.0, 15.0, 'AU');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (101, 1, 'Hello', 500.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (102, 2, 'Hello', 600.0, 2.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (103, 3, 'Hello', 700.0, 3.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (104, 2, 'Alpha', 800.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (105, 1, NULL, 300.0, 5.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (106, NULL, 'Orphan Song', 100.0, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, RHS.song_id AS song_id, RHS.title AS title, RHS.sales AS sales, RHS.highest_position AS highest_position FROM singer AS LHS INNER JOIN song AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY title, name NULLS LAST;

/*
Gold Result:
(None, 'Charlie')
('Alpha', 'Alice')
('Hello', 'Alice')
('Hello', 'Charlie')
('Hello', None)
*/

-- Prediction Query
SELECT T2.Title, T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID;

/*
Prediction Result:
('Hello', 'Charlie')
('Hello', 'Alice')
('Hello', None)
('Alpha', 'Alice')
(None, 'Charlie')
*/