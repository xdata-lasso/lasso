-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (10, 'Movie X', 2021, 'Dir X');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (20, 'Movie Y', 2022, 'Dir Y');
INSERT INTO "Reviewer" ("rID", "name") VALUES (10, 'Zara');
INSERT INTO "Reviewer" ("rID", "name") VALUES (20, 'Aaron');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 10, 5, '2021-05-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 20, 4, '2021-05-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (20, 10, 4, '2021-05-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.mid AS mid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.name AS name FROM (SELECT * FROM rating WHERE (stars > 3)) AS LHS LEFT JOIN reviewer AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
('Aaron',)
('Zara',)
('Zara',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T1.stars > 3;

/*
Prediction Result:
('Zara',)
('Zara',)
('Aaron',)
*/