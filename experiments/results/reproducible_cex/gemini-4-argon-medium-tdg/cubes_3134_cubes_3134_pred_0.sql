-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Monet', 'France', 1990, 45);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (10, 1, 2003, 'Impressionism', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (20, 1, 2004, 'Water Lilies', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (30, 1, 2005, 'Modernism', 25.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (40, 1, NULL, 'Abstract', 10.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (10, '2003-05-01', 100);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (20, '2004-06-01', 200);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (30, '2005-07-01', 300);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (40, '2004-01-01', 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, date, attendance FROM (SELECT LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.artist_id AS artist_id, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance FROM (SELECT * FROM exhibition WHERE (YEAR <= 2004)) AS LHS INNER JOIN exhibition_record AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) ORDER BY theme, date NULLS LAST, attendance NULLS LAST;

/*
Gold Result:
('Impressionism', '2003-05-01', 100)
('Water Lilies', '2004-06-01', 200)
*/

-- Prediction Query
SELECT T2.theme, T1.date, T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id WHERE T2.year = 2004;

/*
Prediction Result:
('Water Lilies', '2004-06-01', 200)
*/