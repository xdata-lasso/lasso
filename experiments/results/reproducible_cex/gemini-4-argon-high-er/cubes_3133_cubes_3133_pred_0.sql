-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2000, 30);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (1, 1, 2020, 'Modern', 10.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (1, '2020-01-01', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, LHS.exhibition_id AS exhibition_id, LHS.year AS YEAR, LHS.theme AS theme, LHS.ticket_price AS ticket_price, RHS.date AS date, RHS.attendance AS attendance, RHS.meanattendance AS meanattendance FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) AS LHS INNER JOIN (SELECT exhibition_id, date, attendance, AVG(attendance) OVER () AS meanattendance FROM exhibition_record) AS RHS ON (LHS.exhibition_id = RHS.exhibition_id)) WHERE (meanattendance <= 200.0 OR meanattendance <> attendance) ORDER BY name;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT T3.name FROM exhibition_record AS T1 JOIN exhibition AS T2 ON T1.exhibition_id = T2.exhibition_id JOIN artist AS T3 ON T3.artist_id = T2.artist_id GROUP BY T3.artist_id HAVING AVG(T1.attendance) > 200;

/*
Prediction Result:
*/