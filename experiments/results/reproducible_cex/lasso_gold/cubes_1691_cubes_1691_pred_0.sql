-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1001, 'Clinical research associate', 1004, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1002, 'Agricultural consultant', 1011.0, 'dog');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1003, 'Haematologist', 1018.0, 'chair');
INSERT INTO "reviewer" ("rid", "name") VALUES (1007, 'Megan Mcclain');
INSERT INTO "reviewer" ("rid", "name") VALUES (1008, 'Javier Johnson');
INSERT INTO "reviewer" ("rid", "name") VALUES (1009, 'Jonathan Johnson');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1007, 1001, 1010, '1970-01-01');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1007, 1001, 1017.0, '1970-01-02');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1007, 1001, 1024.0, '1970-01-03');
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
(1001, 1017.0)
*/