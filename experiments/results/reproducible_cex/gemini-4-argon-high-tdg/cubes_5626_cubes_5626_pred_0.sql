-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Zoe', 'UK', 2021, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Liam', 'Canada', 2015, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Aaron', 'UK', 2021, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Mia', 'Canada', 2021, 20);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (201, 2, 2022, 'Nature', 12.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (202, 1, 2021, 'Portrait', 18.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (201, '2022-03-10', 120);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (202, '2021-07-20', 450);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name_other AS name FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, LHS.maxyear_join AS maxyear_join, RHS.artist_id AS artist_id_other, RHS.name AS name_other, RHS.country AS country_other, RHS.year_join AS year_join_other, RHS.age AS age_other FROM (SELECT artist_id, name, country, year_join, age, MAX(year_join) OVER () AS maxyear_join FROM artist) AS LHS CROSS JOIN artist AS RHS) WHERE (maxyear_join <= year_join_other) ORDER BY name;

/*
Gold Result:
('Aaron',)
('Mia',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM artist ORDER BY year_join DESC, artist.artist_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zoe',)
*/