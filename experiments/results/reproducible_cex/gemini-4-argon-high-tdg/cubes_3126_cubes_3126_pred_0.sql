-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Claude Monet', 'France', 1990, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Georgia O''Keeffe', 'United States', 1985, 60);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Takashi Murakami', 'Vietnam', 2005, 45);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Banksy', NULL, 2010, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'David Hockney', 'United Kingdom', 1998, 70);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2015, 'Impressionism', 25.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 1, 2018, 'Water Lilies', 30.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 2, 2012, 'Modernism', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 4, 2020, 'Street Art', 15.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2015-05-01', 400);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (102, '2018-06-10', 550);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (103, '2012-09-15', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "year_join" FROM "artist" WHERE ("country" <> 'United States') ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('Claude Monet', 1990)
('David Hockney', 1998)
('Takashi Murakami', 2005)
*/

-- Prediction Query
SELECT name, year_join FROM artist WHERE country <> 'United States';

/*
Prediction Result:
('Claude Monet', 1990)
('Takashi Murakami', 2005)
('David Hockney', 1998)
*/