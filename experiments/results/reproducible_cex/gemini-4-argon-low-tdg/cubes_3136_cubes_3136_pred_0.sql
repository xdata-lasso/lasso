-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2005, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Bob', 'UK', 2010, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Charlie', 'Canada', 2015, 28);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (10, 'David', 'France', 2000, 50);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 10, 2020, 'Modern', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 10, 2021, 'Modern', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 10, 2022, 'Classic', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, country FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.artist_id AS artist_id_other, RHS.theme AS theme FROM artist AS LHS INNER JOIN (SELECT artist_id, theme, COUNT(*) AS n FROM exhibition GROUP BY artist_id, theme) AS RHS ON (LHS.artist_id = RHS.n)) ORDER BY name, country NULLS LAST;

/*
Gold Result:
('Alice', 'USA')
('Bob', 'UK')
*/

-- Prediction Query
SELECT T2.name, T2.country FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST, T2.country NULLS LAST LIMIT 1;

/*
Prediction Result:
('David', 'France')
*/