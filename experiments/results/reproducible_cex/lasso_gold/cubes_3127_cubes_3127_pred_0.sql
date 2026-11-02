-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1028, 'Mark Mcclure', 'Kuwait', 1029, 1030);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1031, 'Dennis Williams', 'Micronesia', 1030, 1031);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM exhibition AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
('Dennis Williams',)
('Mark Mcclure',)
*/

-- Prediction Query
SELECT name FROM artist WHERE NOT artist_id IN (SELECT artist_id FROM exhibition);

/*
Prediction Result:
('Mark Mcclure',)
('Dennis Williams',)
*/