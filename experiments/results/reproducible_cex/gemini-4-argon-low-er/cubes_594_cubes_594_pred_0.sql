-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (1, 'Alice', 1990.0, 20.0, 'US');
INSERT INTO singer (Singer_ID, Name, Birth_Year, Net_Worth_Millions, Citizenship) VALUES (2, 'Bob', 1985.0, 10.0, 'UK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM singer ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC, singer.singer_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
*/