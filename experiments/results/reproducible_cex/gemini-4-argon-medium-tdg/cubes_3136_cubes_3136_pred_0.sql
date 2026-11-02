-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Monet', 'France', 1860, 86);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Picasso', 'Spain', 1900, 91);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Van Gogh', 'Netherlands', 1880, 37);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 2, 2020, 'Cubism', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 3, 2021, 'Post-Impressionism', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 3, 2022, 'Post-Impressionism', 25.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 3, 2023, 'Starry Night', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name, country FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.artist_id AS artist_id_other, RHS.theme AS theme FROM artist AS LHS INNER JOIN (SELECT artist_id, theme, COUNT(*) AS n FROM exhibition GROUP BY artist_id, theme) AS RHS ON (LHS.artist_id = RHS.n)) ORDER BY name, country NULLS LAST;

/*
Gold Result:
('Monet', 'France')
('Picasso', 'Spain')
*/

-- Prediction Query
SELECT T2.name, T2.country FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id ORDER BY COUNT(*) DESC, T2.name NULLS LAST, T2.country NULLS LAST LIMIT 1;

/*
Prediction Result:
('Van Gogh', 'Netherlands')
*/