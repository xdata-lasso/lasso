-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, name, country, year_join, age) VALUES (1, 'default2', 'default1', 1, 0), (0, 'default1', NULL, 0, 1), (2, 'default2', 'default2', 0, 0), (3, 'default1', 'default1', 0, 0), (4, 'default1', 'default1', 0, 1), (5, 'default2', 'default1', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "year_join" FROM "artist" WHERE ("country" <> 'United States') ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('default1', 0)
('default1', 0)
('default2', 1)
('default2', 0)
('default2', 1)
*/

-- Prediction Query
SELECT name, year_join FROM artist WHERE country <> 'United States';

/*
Prediction Result:
('default2', 1)
('default2', 0)
('default1', 0)
('default1', 0)
('default2', 1)
*/