-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("Singer_ID", "Name") VALUES (1, 'B');
INSERT INTO "singer" ("Singer_ID", "Name") VALUES (2, 'A');
INSERT INTO "song" ("Song_ID", "Singer_ID") VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM singer AS LHS WHERE NOT EXISTS(SELECT 1 FROM song AS RHS WHERE (LHS.singer_id = RHS.singer_id))) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE NOT Singer_ID IN (SELECT Singer_ID FROM song);

/*
Prediction Result:
*/