-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2010, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'USA', 2015, 30);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2020, 'Modern', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 2, 2021, 'Classic', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id;

/*
Prediction Result:
('Alice', 1)
('Alice', 1)
*/