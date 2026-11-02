-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Zara', 1980.0, 10.0, 'US');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1995.0, 50.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, 'Bob', 1970.0, 100.0, 'CA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (4, 'Alice', 1985.0, 20.0, 'FR');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (10, 3, 'Hit1', 500.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (11, 3, 'Hit2', 300.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM singer AS LHS WHERE NOT EXISTS(SELECT 1 FROM song AS RHS WHERE (LHS.singer_id = RHS.singer_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE NOT Singer_ID IN (SELECT Singer_ID FROM song);

/*
Prediction Result:
('Zara',)
('Alice',)
('Alice',)
*/