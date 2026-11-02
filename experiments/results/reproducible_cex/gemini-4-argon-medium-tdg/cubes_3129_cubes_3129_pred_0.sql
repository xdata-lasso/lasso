-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2010, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Bob', 'Canada', 2015, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Charlie', 'USA', 2012, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Diana', 'Brazil', 2018, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM artist ORDER BY country;

/*
Gold Result:
('Brazil',)
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT DISTINCT country FROM artist;

/*
Prediction Result:
('USA',)
('Canada',)
('Brazil',)
*/