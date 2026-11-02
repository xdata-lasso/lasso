-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic functionality, duplicate names (SELECT vs SELECT DISTINCT), ordering (ORDER BY name vs artist_id), and multiple exhibitions per artist.
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Zack', 'USA', 2000, 45);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'UK', 2005, 38);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Alice', 'Canada', 2010, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Bob', 'France', 1995, 60);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'Charlie', 'Germany', 2015, 25);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 4, 2020, 'Modern', 15.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 5, 2021, 'Abstract', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 5, 2022, 'Future', 25.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2020-05-01', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM exhibition AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM artist WHERE NOT artist_id IN (SELECT artist_id FROM exhibition);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/