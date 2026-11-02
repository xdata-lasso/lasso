-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT JOIN (artists with 0 exhibitions, exhibitions with NULL Artist_ID)
-- Tests COUNT(*) vs COUNT(DISTINCT artist_id) and COUNT(nullable_columns)
-- Tests GROUP BY (age, name) where two artists have the same name but different ages, and vice versa
-- Tests ORDER BY name ASC, count___ ASC tie-breaking
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2010, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'UK', 2012, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Bob', 'Canada', 2015, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Charlie', 'France', 2018, 50);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2020, 'Modern', 15.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 1, 2021, NULL, NULL);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 1, 2022, 'Abstract', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 2, 2020, 'Nature', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (105, 3, 2021, 'Urban', 12.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (106, NULL, 2022, 'Orphan', 5.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2020-01-01', 100);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2020-01-02', 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Bob', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id;

/*
Prediction Result:
('Alice', 3)
('Alice', 1)
('Bob', 1)
*/