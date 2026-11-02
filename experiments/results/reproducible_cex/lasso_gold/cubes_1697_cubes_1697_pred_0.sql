-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1066, 'Bonds trader', 1067, 'value');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1069, 'Software engineer', 1068, 'image');
INSERT INTO "reviewer" ("rid", "name") VALUES (1068, 'Zachary Rice');
INSERT INTO "reviewer" ("rid", "name") VALUES (1071, 'Melanie Wilson');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1068, 1066, 5, '1991-11-22');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1071, 1069, 5, '1992-01-23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director, title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars = 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY director, title NULLS LAST;

/*
Gold Result:
('image', 'Software engineer')
('value', 'Bonds trader')
*/

-- Prediction Query
SELECT T1.director, T1.title FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID WHERE T2.stars = 5;

/*
Prediction Result:
('value', 'Bonds trader')
('image', 'Software engineer')
*/