-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (10, 'Alice', 'USA', 2020, 60);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (20, 'Zara', 'France', 2005, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (30, 'Charlie', 'Germany', 2010, 45);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (40, 'Bob', 'Brazil', 1990, 22);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 10, 2021, 'Abstract', 50.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 10, 2022, 'Portrait', 75.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 40, 2018, 'Nature', 10.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2021-05-01', 500);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (102, '2022-06-15', 1200);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (103, '2018-03-10', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM artist ORDER BY name DESC, artist.artist_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Zara',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/