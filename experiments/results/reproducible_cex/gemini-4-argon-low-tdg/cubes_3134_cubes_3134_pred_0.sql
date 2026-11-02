-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests YEAR boundary conditions (2003, 2004, 2005, NULL) and column confusion (Year_Join vs Year)
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Picasso', 'Spain', 2005, 91);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Dali', 'Spain', 2003, 84);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Miro', 'Spain', 2004, 90);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2003, 'Cubism', 15.50);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 1, 2004, 'Surrealism', 20.00);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 2, 2005, 'Modernism', 25.00);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 3, NULL, 'Abstract', 10.00);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2003-05-01', 150);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (102, '2004-06-15', 200);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (103, '2005-07-20', 300);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (104, '2004-08-10', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, date, attendance FROM (SELECT LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.artist_id AS artist_id, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance FROM (SELECT * FROM exhibition WHERE (YEAR <= 2004)) AS LHS INNER JOIN exhibition_record AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) ORDER BY theme, date NULLS LAST, attendance NULLS LAST;

/*
Gold Result:
('Cubism', '2003-05-01', 150)
('Surrealism', '2004-06-15', 200)
*/

-- Prediction Query
SELECT T2.theme, T1.date, T1.attendance FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id WHERE T2.year = 2004;

/*
Prediction Result:
('Surrealism', '2004-06-15', 200)
*/