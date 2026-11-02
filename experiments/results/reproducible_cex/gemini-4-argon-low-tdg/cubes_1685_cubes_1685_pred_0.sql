-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT year) vs COUNT(year) / COUNT(*) (duplicate years 1995)
-- 2. Boundary condition: year < 2000 vs year <= 2000 (includes 2000 and 1999)
-- 3. WHERE clause filtering vs no filtering (includes 2005)
-- 4. NULL handling in WHERE and COUNT
-- 5. Unrated movies vs inner join with Rating/Reviewer (only mID 1 is rated)
-- 6. Counting distinct years vs distinct titles or directors (same title/director across different years, different title/director in same year)
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Alpha', 1995, 'DirA');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Beta', 1995, 'DirB');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Alpha', 1999, 'DirA');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Gamma', 2000, 'DirC');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Delta', 2005, 'DirD');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Epsilon', NULL, 'DirE');
INSERT INTO "Reviewer" ("rID", "name") VALUES (101, 'Rev1');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 1, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 1, 4, '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT YEAR) AS n_distinct FROM (SELECT * FROM movie WHERE (YEAR < 2000))) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Movie WHERE YEAR < 2000;

/*
Prediction Result:
(3,)
*/