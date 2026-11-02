-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Bob', 1948.0, 10.0, 'USA');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Alice', 1949.0, 20.0, 'UK');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (3, 'Charlie', 1948.5, 15.0, 'Canada');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM singer WHERE (birth_year >= 1948.0 AND birth_year <= 1949.0) ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Birth_Year = 1948 OR Birth_Year = 1949;

/*
Prediction Result:
('Bob',)
('Alice',)
*/