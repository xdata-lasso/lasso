-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Snow White', 1937, NULL);
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'James Cameron');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(stars) OVER () AS max_stars_, minstars AS min_stars_ FROM (SELECT rid, mid, stars, ratingdate, MIN(stars) OVER () AS minstars FROM rating) ORDER BY max_stars_, min_stars_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(stars), MIN(stars) FROM Rating;

/*
Prediction Result:
(None, None)
*/