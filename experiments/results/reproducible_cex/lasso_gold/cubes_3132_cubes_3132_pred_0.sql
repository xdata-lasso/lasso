-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1033, 'Mark Mcclure', 'Guyana', 1034, 1035);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1036, 'Mark Mcclure', 'Guyana', 1034, 1035);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM exhibition WHERE (YEAR = 2004)) AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
('Mark Mcclure',)
('Mark Mcclure',)
*/

-- Prediction Query
SELECT name FROM artist EXCEPT SELECT T2.name FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id WHERE T1.year = 2004;

/*
Prediction Result:
('Mark Mcclure',)
*/