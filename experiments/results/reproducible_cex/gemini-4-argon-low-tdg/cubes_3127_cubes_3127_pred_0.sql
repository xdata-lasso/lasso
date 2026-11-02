-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join behavior, ORDER BY Name (inserted out of order), and Artist_ID colliding with Exhibition_ID.
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Zoe', 'USA', 2010, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'UK', 2012, 28);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Bob', 'Canada', 2015, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Charlie', 'France', 2018, 30);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (2, 3, 2020, 'Modern', 15.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (3, 3, 2021, 'Abstract', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (5, 4, 2022, 'Classic', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM exhibition AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM artist WHERE NOT artist_id IN (SELECT artist_id FROM exhibition);

/*
Prediction Result:
('Zoe',)
('Alice',)
*/