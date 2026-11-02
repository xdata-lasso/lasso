-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1101, NULL, 1102, 'hour');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1105, 'Set designer', 1106, 'why');
INSERT INTO "reviewer" ("rid", "name") VALUES (1103, 'Kimberly Osborne');
INSERT INTO "reviewer" ("rid", "name") VALUES (1107, 'Kimberly Osborne');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1103, 1101, 1104, '1994-03-02');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1107, 1105, 1108, '1995-04-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, title, stars, ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.name AS name, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.name AS name FROM movie AS LHS CROSS JOIN reviewer AS RHS) AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid AND LHS.rid = RHS.rid)) ORDER BY name, title NULLS LAST, stars NULLS LAST, ratingdate NULLS LAST;

/*
Gold Result:
('Kimberly Osborne', 'Set designer', 1108, '1995-04-03')
('Kimberly Osborne', None, 1104, '1994-03-02')
*/

-- Prediction Query
SELECT T3.name, T2.title, T1.stars, T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID ORDER BY T3.name, T2.title, T1.stars, T1.rid NULLS LAST, T1.mid NULLS LAST, T1.ratingdate NULLS LAST, T2.mid NULLS LAST, T3.rid NULLS LAST;

/*
Prediction Result:
('Kimberly Osborne', None, 1104, '1994-03-02')
('Kimberly Osborne', 'Set designer', 1108, '1995-04-03')
*/