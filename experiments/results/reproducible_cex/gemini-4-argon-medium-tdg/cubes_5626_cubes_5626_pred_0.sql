-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (1, 'Charlie', 'Canada', 2020, 30);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (2, 'Alice', 'Canada', 2020, 45);
INSERT INTO "artist" ("Artist_ID", "Name", "Country", "Year_Join", "Age") VALUES (3, 'Bob', 'USA', 2018, 60);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (201, 3, 2021, 'Classic', 20.0);
INSERT INTO "exhibition" ("Exhibition_ID", "Artist_ID", "Year", "Theme", "Ticket_Price") VALUES (202, 1, 2019, 'Abstract', 10.0);
INSERT INTO "exhibition_record" ("Exhibition_ID", "Date", "Attendance") VALUES (201, '2021-05-01', 1200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, LHS.maxyear_join AS maxyear_join, RHS.artist_id AS artist_id_other, RHS.name AS name_other, RHS.country AS country_other, RHS.year_join AS year_join_other, RHS.age AS age_other FROM (SELECT artist_id, name, country, year_join, age, MAX(year_join) OVER () AS maxyear_join FROM artist) AS LHS CROSS JOIN artist AS RHS) WHERE (maxyear_join <= year_join_other) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Charlie',)
*/