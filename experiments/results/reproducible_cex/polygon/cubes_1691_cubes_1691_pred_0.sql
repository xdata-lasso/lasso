-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (8, '11', 11, '11');
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (11, '11', 11, '11');
INSERT INTO "Reviewer" ("rid", "name") VALUES (10, '11');
INSERT INTO "Reviewer" ("rid", "name") VALUES (9, '11');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (9, 11, 142, '1000-01-12');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (9, 11, -139, '1000-01-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mid, meanstars AS avg_stars_ FROM (SELECT mid, meanstars, COUNT(*) OVER () AS n FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) WHERE (meanstars >= 2.0 AND meanstars <= n) ORDER BY mid, avg_stars_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT mID, AVG(stars) FROM Rating GROUP BY mID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(11, 1.5)
*/