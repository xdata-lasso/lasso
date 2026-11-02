-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO artist (artist_id, name, country, year_join, age) VALUES (1, 'default2', 'default1', NULL, NULL), (0, 'default2', 'default1', NULL, NULL);
INSERT INTO exhibition (exhibition_id, artist_id, year, theme, ticket_price) VALUES (1, 1, NULL, NULL, NULL), (0, 0, 1, 'default1', NULL), (2, 1, 0, 'default2', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
(None, None)
('default1', 1)
('default2', 0)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition ORDER BY ticket_price DESC, exhibition.exhibition_id NULLS LAST;

/*
Prediction Result:
('default2', 0)
('default1', 1)
(None, None)
*/