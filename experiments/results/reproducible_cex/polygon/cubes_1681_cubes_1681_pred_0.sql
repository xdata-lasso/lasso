-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (15, '-245', -245, '-245');
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (12, '-245', -245, '-245');
INSERT INTO "Reviewer" ("rid", "name") VALUES (14, '34');
INSERT INTO "Reviewer" ("rid", "name") VALUES (13, '34');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (14, 15, -245, '1000-02-07');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (13, 15, -245, '1000-02-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('34', -245.0)
('34', -245.0)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('34', -245.0)
*/