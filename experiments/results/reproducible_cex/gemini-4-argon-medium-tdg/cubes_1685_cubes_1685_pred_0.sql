-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT year) vs COUNT(year) / COUNT(*) (duplicate years 1990)
-- 2. Boundary condition: year = 2000 (< vs <=) and year = 1999 (< 2000 vs < 1999)
-- 3. Direction of operator: > 2000 vs < 2000
-- 4. NULL year handling
-- 5. Unrelated movies not in Rating table vs movies with multiple ratings (catches unnecessary JOINs)
-- 6. Counting wrong columns (e.g., title or director) by having distinct count of years (2: 1990, 1999) differ from distinct titles (3) and directors (1)
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Movie A', 1990, 'Director X');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Movie B', 1990, 'Director X');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Movie C', 1999, 'Director X');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Movie D', 2000, 'Director Y');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Movie E', 2005, 'Director Z');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Movie F', NULL, 'Director X');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Reviewer 1');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, 'Reviewer 2');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 1, 5, '1995-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 1, 4, '1996-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 4, 3, '2001-01-01');
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