-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1008, 'Kimberly Robinson', 'Cuba', 1009, 1010);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (1011, 'Javier Johnson', 'Saint Barthelemy', 1010, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, country FROM artist ORDER BY name, artist.artist_id NULLS LAST;

/*
Gold Result:
('Javier Johnson', 1011, 'Saint Barthelemy')
('Kimberly Robinson', 1010, 'Cuba')
*/

-- Prediction Query
SELECT name, age, country FROM artist ORDER BY Year_Join, artist.artist_id NULLS LAST;

/*
Prediction Result:
('Kimberly Robinson', 1010, 'Cuba')
('Javier Johnson', 1011, 'Saint Barthelemy')
*/