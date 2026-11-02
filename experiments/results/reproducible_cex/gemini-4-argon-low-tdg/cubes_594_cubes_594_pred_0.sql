-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL values in Name (kills ORDER BY name NULLS LAST or WHERE name IS NOT NULL) and NULL Singer_ID (kills missing NULLS LAST on singer_id).
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (NULL, 'Zara', 2000.0, 5.0, 'Spain');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (10, NULL, 1995.0, 15.0, 'Italy');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (5, 'Zara', 1992.0, 25.0, 'Germany');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (20, 'Aaron', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM singer ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Zara',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC, singer.singer_id NULLS LAST;

/*
Prediction Result:
('Aaron',)
('Zara',)
(None,)
('Zara',)
*/