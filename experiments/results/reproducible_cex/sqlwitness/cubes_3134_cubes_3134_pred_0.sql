-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO exhibition (exhibition_id, artist_id, year, theme, ticket_price) VALUES (0, NULL, 2003, NULL, 1.0), (1, NULL, NULL, NULL, 0.0), (2003, NULL, 2003, 'default2', 0.0), (2004, NULL, 1, 'default1', 0.0), (2005, NULL, 2004, NULL, 0.0);
INSERT INTO exhibition_record (exhibition_id, date, attendance) VALUES (2004, 'default1', 0), (2003, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, date, attendance FROM (SELECT LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.artist_id AS artist_id, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance FROM (SELECT * FROM exhibition WHERE (YEAR <= 2004)) AS LHS INNER JOIN exhibition_record AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) ORDER BY theme, date NULLS LAST, attendance NULLS LAST;

/*
Gold Result:
('default1', 'default1', 0)
('default2', 'default2', None)
*/

-- Prediction Query
SELECT T2.theme, T1.date, T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id WHERE T2.year = 2004;

/*
Prediction Result:
*/