-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1025, 'Legal secretary', 1026, 'blue');
INSERT INTO "reviewer" ("rid", "name") VALUES (1027, 'Brent Abbott');
INSERT INTO "reviewer" ("rid", "name") VALUES (1029, 'Brent Abbott');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1027, 1025, 1028, '1976-07-07');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1029, 1025, 1028, '1977-08-08');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Brent Abbott', 1028.0)
('Brent Abbott', 1028.0)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('Brent Abbott', 1028.0)
*/