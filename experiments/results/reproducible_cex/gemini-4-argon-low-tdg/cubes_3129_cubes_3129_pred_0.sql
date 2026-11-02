-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic DISTINCT (duplicates), ORDER BY ASC vs DESC/unsorted, and INNER JOIN mutants (artists with and without exhibitions).
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (1, 'Picasso', 'Spain', 1900, 91);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (2, 'Monet', 'France', 1860, 86);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (3, 'Dali', 'Spain', 1920, 84);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (4, 'Hokusai', 'Japan', 1778, 88);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (101, 1, 1937, 'Modernism', 25.5);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (102, 2, 1874, 'Impressionism', 15.0);
INSERT INTO "exhibition_record" ("Exhibition_ID", "Date", "Attendance") VALUES (101, '1937-05-01', 500);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM artist ORDER BY country;

/*
Gold Result:
('France',)
('Japan',)
('Spain',)
*/

-- Prediction Query
SELECT DISTINCT country FROM artist;

/*
Prediction Result:
('Spain',)
('France',)
('Japan',)
*/