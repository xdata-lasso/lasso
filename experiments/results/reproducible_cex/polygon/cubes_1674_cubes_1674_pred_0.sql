-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (7, '797', 797, '797');
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (10, '797', 797, '797');
INSERT INTO "Reviewer" ("rid", "name") VALUES (8, '797');
INSERT INTO "Reviewer" ("rid", "name") VALUES (9, '797');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (9, 10, 797, '1000-01-12');
INSERT INTO "Rating" ("rid", "mid", "stars", "ratingdate") VALUES (9, 7, 798, '1002-03-09');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(stars) OVER () AS max_stars_, minstars AS min_stars_ FROM (SELECT rid, mid, stars, ratingdate, MIN(stars) OVER () AS minstars FROM rating) ORDER BY max_stars_, min_stars_ NULLS LAST;

/*
Gold Result:
(798, 797)
*/

-- Prediction Query
SELECT MAX(stars), MIN(stars) FROM Rating;

/*
Prediction Result:
(798, 797)
*/