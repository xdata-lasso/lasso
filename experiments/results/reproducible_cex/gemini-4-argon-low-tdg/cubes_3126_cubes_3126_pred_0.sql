-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (1, 'Claude Monet', 'France', 1995, 45);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (2, 'Andy Warhol', 'United States', 2000, 35);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (3, 'Pablo Picasso', 'Spain', 1990, 50);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (4, 'Frida Kahlo', 'Mexico', 2005, 30);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (101, 1, 2020, 'Impressionism', 25.0);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (102, 1, 2021, 'Water Lilies', 30.0);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (103, 2, 2022, 'Pop Art', 20.0);
INSERT INTO "exhibition_record" ("Exhibition_ID", "Date", "Attendance") VALUES (101, '2020-05-01', 500);
INSERT INTO "exhibition_record" ("Exhibition_ID", "Date", "Attendance") VALUES (101, '2020-05-02', 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "year_join" FROM "artist" WHERE ("country" <> 'United States') ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('Claude Monet', 1995)
('Frida Kahlo', 2005)
('Pablo Picasso', 1990)
*/

-- Prediction Query
SELECT name, year_join FROM artist WHERE country <> 'United States';

/*
Prediction Result:
('Claude Monet', 1995)
('Pablo Picasso', 1990)
('Frida Kahlo', 2005)
*/