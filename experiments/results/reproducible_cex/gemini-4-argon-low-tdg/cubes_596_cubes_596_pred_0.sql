-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY tie-breaking (same Title, different Name), NULLS LAST vs NULLS FIRST on both sort columns.
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Charlie', 1975.0, 15.0, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1992.0, 25.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, NULL, 1988.0, 8.0, 'France');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (1, 1, 'Halo', 500.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (2, 2, 'Halo', 600.0, 2.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (3, 3, 'Halo', 300.0, 5.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (4, 2, NULL, 150.0, 12.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (5, 3, NULL, 100.0, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, name FROM (SELECT LHS.singer_id AS singer_id, LHS.name AS name, LHS.birth_year AS birth_year, LHS.net_worth_millions AS net_worth_millions, LHS.citizenship AS citizenship, RHS.song_id AS song_id, RHS.title AS title, RHS.sales AS sales, RHS.highest_position AS highest_position FROM singer AS LHS INNER JOIN song AS RHS ON (LHS.singer_id = RHS.singer_id)) ORDER BY title, name NULLS LAST;

/*
Gold Result:
(None, 'Alice')
(None, None)
('Halo', 'Alice')
('Halo', 'Charlie')
('Halo', None)
*/

-- Prediction Query
SELECT T2.Title, T1.Name FROM singer AS T1 JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID;

/*
Prediction Result:
('Halo', 'Charlie')
('Halo', 'Alice')
('Halo', None)
(None, 'Alice')
(None, None)
*/