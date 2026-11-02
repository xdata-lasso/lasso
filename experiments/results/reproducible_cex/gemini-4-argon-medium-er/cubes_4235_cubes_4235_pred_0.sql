-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'M', 2000, 'D');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'A');
INSERT INTO "Reviewer" ("rID", "name") VALUES (2, 'A');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 1, 5, '2020-02-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 1, 5, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, title, stars, ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.name AS name, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.name AS name FROM movie AS LHS CROSS JOIN reviewer AS RHS) AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid AND LHS.rid = RHS.rid)) ORDER BY name, title NULLS LAST, stars NULLS LAST, ratingdate NULLS LAST;

/*
Gold Result:
('A', 'M', 5, '2020-01-01')
('A', 'M', 5, '2020-02-01')
*/

-- Prediction Query
SELECT T3.name, T2.title, T1.stars, T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID ORDER BY T3.name, T2.title, T1.stars, T1.rid NULLS LAST, T1.mid NULLS LAST, T1.ratingdate NULLS LAST, T2.mid NULLS LAST, T3.rid NULLS LAST;

/*
Prediction Result:
('A', 'M', 5, '2020-02-01')
('A', 'M', 5, '2020-01-01')
*/