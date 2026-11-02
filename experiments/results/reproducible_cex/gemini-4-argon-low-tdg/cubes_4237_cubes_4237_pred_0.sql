-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT JOIN (movies with 0 ratings), COUNT(*) vs COUNT(director) (NULL director), and NULLS LAST ordering.
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Unrated Movie', 2000, 'Zack');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Anon Movie', 2001, NULL);
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Alpha Movie', 2002, 'Alice');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Beta Movie', 2003, 'Bob');
INSERT INTO "Reviewer" ("rID", "name") VALUES (101, 'Rev1');
INSERT INTO "Reviewer" ("rID", "name") VALUES (102, 'Rev2');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 2, 4, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 3, 5, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 4, 3, '2020-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (102, 4, 4, '2020-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, director FROM (SELECT director, COUNT(*) AS n FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) GROUP BY director) ORDER BY count___, director NULLS LAST;

/*
Gold Result:
(1, 'Alice')
(1, None)
(2, 'Bob')
*/

-- Prediction Query
SELECT COUNT(*), T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID GROUP BY T1.director;

/*
Prediction Result:
(1, None)
(1, 'Alice')
(2, 'Bob')
*/