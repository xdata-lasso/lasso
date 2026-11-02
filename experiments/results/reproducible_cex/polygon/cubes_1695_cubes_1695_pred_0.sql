-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (13, '21', -145, '17');
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (12, '22', -145, '18');
INSERT INTO "Reviewer" ("rid", "name") VALUES (15, '-145');
INSERT INTO "Reviewer" ("rid", "name") VALUES (14, '-145');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (14, 12, -145, '0999-08-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.mid AS mid_other, RHS.director AS director_other FROM (SELECT mid, title, MAX(YEAR) OVER () AS YEAR, director FROM movie) AS LHS INNER JOIN movie AS RHS ON (LHS.title = RHS.title AND LHS.year = RHS.year)) ORDER BY title;

/*
Gold Result:
('21',)
('22',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR = (SELECT MAX(YEAR) FROM Movie);

/*
Prediction Result:
('22',)
('21',)
*/