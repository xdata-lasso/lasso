-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (12, NULL, '18', -55, 20);
INSERT INTO "artist" ("artist_id", "name", "country", "year_join", "age") VALUES (11, NULL, '19', -55, 21);
INSERT INTO "exhibition" ("exhibition_id", "artist_id", "year", "theme", "ticket_price") VALUES (13, 11, -55, '-55', -55);
INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (13, '15', -55);
INSERT INTO "exhibition_record" ("exhibition_id", "date", "attendance") VALUES (13, '14', -55);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, LHS.maxyear_join AS maxyear_join, RHS.artist_id AS artist_id_other, RHS.name AS name_other, RHS.country AS country_other, RHS.year_join AS year_join_other, RHS.age AS age_other FROM (SELECT artist_id, name, country, year_join, age, MAX(year_join) OVER () AS maxyear_join FROM artist) AS LHS CROSS JOIN artist AS RHS) WHERE (maxyear_join <= year_join_other) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/