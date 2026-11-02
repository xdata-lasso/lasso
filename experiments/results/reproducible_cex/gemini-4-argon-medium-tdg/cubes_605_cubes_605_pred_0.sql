-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (1, 'Alice', 1990.0, 5.0, 'France');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (2, 'Bob', 1985.0, 10.0, 'USA');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (3, 'Bob', 1980.0, 20.0, 'UK');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (4, 'Charlie', 1995.0, 2.0, NULL);
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (5, NULL, 2000.0, 1.0, 'Spain');
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (101, 2, 'Hit 1', 100.0, 1.0);
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (102, 2, 'Hit 2', 200.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "singer" WHERE ("citizenship" <> 'France') ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
(None,)
('Bob',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Citizenship <> 'France';

/*
Prediction Result:
('Bob',)
('Bob',)
(None,)
*/