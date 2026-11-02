-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (1, 'B', 'Canada', 2000, 30);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (2, 'A', 'Canada', 2001, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "year_join" FROM "artist" WHERE ("country" <> 'United States') ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('A', 2001)
('B', 2000)
*/

-- Prediction Query
SELECT name, year_join FROM artist WHERE country <> 'United States';

/*
Prediction Result:
('B', 2000)
('A', 2001)
*/