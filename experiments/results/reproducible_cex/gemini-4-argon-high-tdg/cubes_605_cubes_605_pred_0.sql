-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (1, 'Zara', 1990.0, 10.5, 'USA');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (2, 'France', 1985.0, 20.0, 'France');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (3, 'Alice', 1995.0, 5.0, 'UK');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (4, 'Bob', 1980.0, 50.0, 'France');
INSERT INTO "singer" ("Singer_ID", "Name", "Birth_Year", "Net_Worth_Millions", "Citizenship") VALUES (5, 'France', 1992.0, 15.0, 'Canada');
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (1, 2, 'Parisian Nights', 500.0, 1.0);
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (2, 3, 'London Rain', 300.0, 2.0);
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (3, 3, 'Thames Breeze', 450.0, 1.0);
INSERT INTO "song" ("Song_ID", "Singer_ID", "Title", "Sales", "Highest_Position") VALUES (4, 4, 'Bordeaux', 200.0, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "singer" WHERE ("citizenship" <> 'France') ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Alice',)
('France',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Citizenship <> 'France';

/*
Prediction Result:
('Zara',)
('Alice',)
('France',)
*/