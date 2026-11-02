-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1078, 'Oceanographer', 1079, 'high');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1086, 'Pharmacist, hospital', 1087, 'pick');
INSERT INTO "reviewer" ("rid", "name") VALUES (1080, 'Zachary Hicks');
INSERT INTO "reviewer" ("rid", "name") VALUES (1088, 'James Ferrell');
INSERT INTO "reviewer" ("rid", "name") VALUES (1084, NULL);
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1080, 1078, 1081, '1988-08-19');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1084, 1078, 1085, '1989-09-20');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1088, 1086, 1089, '1990-10-21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, director FROM (SELECT director, COUNT(*) AS n FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) GROUP BY director) ORDER BY count___, director NULLS LAST;

/*
Gold Result:
(1, 'pick')
(2, 'high')
*/

-- Prediction Query
SELECT COUNT(*), T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID GROUP BY T1.director;

/*
Prediction Result:
(2, 'high')
(1, 'pick')
*/