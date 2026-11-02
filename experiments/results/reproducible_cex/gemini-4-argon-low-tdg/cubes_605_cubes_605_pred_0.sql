-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (1, 'Zara', 1995.0, 10.0, 'france');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (2, 'Anna', 1992.0, 15.0, 'France');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (3, NULL, 1988.0, 20.0, 'Canada');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (4, 'France', 1982.0, 25.0, 'Spain');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "singer" WHERE ("citizenship" <> 'France') ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
(None,)
('France',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Citizenship <> 'France';

/*
Prediction Result:
('Zara',)
(None,)
('France',)
*/