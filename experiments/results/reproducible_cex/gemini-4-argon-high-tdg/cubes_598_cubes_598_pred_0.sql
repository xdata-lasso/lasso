-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Charlie', 1985.0, 12.5, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1992.0, 8.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, 'Bob', 1978.0, 25.0, 'Canada');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (4, 'David', 1990.0, 15.0, 'Australia');
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (1, 3, 'First Hit', 500000.0, 1.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (2, 4, 'Summer Breeze', 250000.0, 5.0);
INSERT INTO song (Song_ID, Singer_ID, Title, Sales, Highest_Position) VALUES (5, 4, 'Winter Cold', 120000.0, 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM singer AS LHS WHERE NOT EXISTS(SELECT 1 FROM song AS RHS WHERE (LHS.singer_id = RHS.singer_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE NOT Singer_ID IN (SELECT Singer_ID FROM song);

/*
Prediction Result:
('Charlie',)
('Alice',)
*/