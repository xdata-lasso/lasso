-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, name, country, year_join, age) VALUES (1, 'default1', 'default2', 1, 0), (0, 'default1', NULL, NULL, 1), (2, NULL, NULL, NULL, 0), (3, 'default1', NULL, 1, 1), (4, 'default2', NULL, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM artist ORDER BY country;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT country FROM artist;

/*
Prediction Result:
(None,)
('default2',)
*/