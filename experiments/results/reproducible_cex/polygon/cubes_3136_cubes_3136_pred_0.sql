-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1, '28', NULL, 22, 23);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (13, '24', NULL, NULL, NULL);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (15, 13, 32, NULL, 33);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (14, 1, NULL, NULL, NULL);
INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (15, '1', 1);
INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (14, '1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, country FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.artist_id AS artist_id_other, RHS.theme AS theme FROM artist AS LHS INNER JOIN (SELECT artist_id, theme, COUNT(*) AS n FROM exhibition GROUP BY artist_id, theme) AS RHS ON (LHS.artist_id = RHS.n)) ORDER BY name, country NULLS LAST;

/*
Gold Result:
('28', None)
*/

-- Prediction Query
SELECT T2.name, T2.country FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST, T2.country NULLS LAST LIMIT 1;

/*
Prediction Result:
('24', None)
*/