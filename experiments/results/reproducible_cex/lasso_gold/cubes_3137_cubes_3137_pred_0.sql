-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1007, 'Megan Mcclain', 'Benin', 1008, 1009);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1013, NULL, 'Madagascar', 1014, 1015);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1010, 1007, 1011, 'performance', 1012.5);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (1016, 1013, 1017, 'play', 1018.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('Megan Mcclain', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id;

/*
Prediction Result:
('Megan Mcclain', 1)
(None, 1)
*/