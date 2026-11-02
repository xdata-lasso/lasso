-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard alphabetical sorting by Name DESC vs sorting by Age, Year_Join, Country, or Artist_ID.
-- Also tests joins with exhibition/exhibition_record (Zack has no exhibitions, Alice has one).
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2020, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Bob', 'UK', 2010, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Zack', 'France', 1990, 20);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (10, 1, 2021, 'Modern', 15.5);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (10, '2021-05-01', 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM artist ORDER BY name DESC, artist.artist_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Zack',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/