-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2000, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'UK', 2005, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Alice', 'Canada', 2010, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Bob', 'USA', 2012, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'Charlie', 'France', 2015, 45);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2020, 'Modern', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 1, 2021, 'Abstract', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 2, 2020, 'Nature', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 3, 2019, 'Portrait', 25.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (105, 3, 2020, 'Landscape', 30.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (106, 3, 2022, 'Sculpture', 35.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (107, 4, 2021, 'Pop', 12.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 2)
('Alice', 3)
('Bob', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id;

/*
Prediction Result:
('Alice', 2)
('Alice', 1)
('Alice', 3)
('Bob', 1)
*/