-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, name, country, year_join, age) VALUES (2, 'default1', 'default2', 1, 0), (0, NULL, NULL, 0, 1), (1, 'default1', 'default2', NULL, 1);
INSERT INTO exhibition (exhibition_id, artist_id, year, theme, ticket_price) VALUES (1, NULL, 2, NULL, NULL), (2, 2, NULL, NULL, NULL), (0, 2, 2, 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM exhibition AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT name FROM artist WHERE NOT artist_id IN (SELECT artist_id FROM exhibition);

/*
Prediction Result:
*/