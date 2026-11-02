-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2010, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'USA', 2010, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Alice', 'UK', 2015, 25);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Bob', 'Canada', 2008, 45);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'Charlie', 'France', 2020, 18);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2021, 'Modern Art', 25.50);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 1, 2022, 'Abstract', 30.00);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 4, 2019, 'Classics', 15.00);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2021-05-01', 150);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2021-05-02', 200);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (103, '2019-10-10', 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, country FROM artist ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('Alice', 30, 'USA')
('Alice', 30, 'USA')
('Alice', 25, 'UK')
('Bob', 45, 'Canada')
('Charlie', 18, 'France')
*/

-- Prediction Query
SELECT name, age, country FROM artist ORDER BY Year_Join, artist.artist_id NULLS LAST;

/*
Prediction Result:
('Bob', 45, 'Canada')
('Alice', 30, 'USA')
('Alice', 30, 'USA')
('Alice', 25, 'UK')
('Charlie', 18, 'France')
*/