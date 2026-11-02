-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1001, 'Allison Hill', 'Anguilla', 1005, 1009);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1002, 'Noah Rhodes', 'Monaco', 1014.0, 1020.0);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1003, 'Angie Henderson', 'Congo', 1023.0, 1031.0);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1004, 'Daniel Wagner', 'Saint Barthelemy', 1032.0, 1042.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM artist ORDER BY name DESC, artist.artist_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Noah Rhodes',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/