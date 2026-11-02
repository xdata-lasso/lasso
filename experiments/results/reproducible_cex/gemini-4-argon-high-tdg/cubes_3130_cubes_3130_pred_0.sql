-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (10, 'Zara', 'France', 2015, 25);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (20, 'Alice', 'USA', 2010, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'Alice', 'Canada', 2020, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (15, 'Bob', 'UK', 2005, 40);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (100, 10, 2018, 'Modern', 15.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 10, 2019, 'Abstract', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 5, 2021, 'Nature', 12.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (100, '2018-05-01', 150);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (100, '2018-05-02', 200);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (102, '2021-06-10', 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, country FROM artist ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('Alice', 30, 'Canada')
('Alice', 50, 'USA')
('Bob', 40, 'UK')
('Zara', 25, 'France')
*/

-- Prediction Query
SELECT name, age, country FROM artist ORDER BY Year_Join, artist.artist_id NULLS LAST;

/*
Prediction Result:
('Bob', 40, 'UK')
('Alice', 50, 'USA')
('Zara', 25, 'France')
('Alice', 30, 'Canada')
*/