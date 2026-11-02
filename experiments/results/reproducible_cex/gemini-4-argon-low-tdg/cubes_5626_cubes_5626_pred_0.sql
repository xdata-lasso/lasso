-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Charlie', 'France', 1995, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alpha', 'Germany', 2022, 28);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Bravo', 'Spain', 2022, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Delta', 'Italy', 2005, 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, LHS.maxyear_join AS maxyear_join, RHS.artist_id AS artist_id_other, RHS.name AS name_other, RHS.country AS country_other, RHS.year_join AS year_join_other, RHS.age AS age_other FROM (SELECT artist_id, name, country, year_join, age, MAX(year_join) OVER () AS maxyear_join FROM artist) AS LHS CROSS JOIN artist AS RHS) WHERE (maxyear_join <= year_join_other) ORDER BY name;

/*
Gold Result:
('Alpha',)
('Bravo',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/