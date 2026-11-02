-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (1, 'default2'), (0, NULL), (2, 'default2');
INSERT INTO movie (mid, title, year, director) VALUES (1, 'default1', NULL, NULL), (0, 'default1', NULL, NULL), (2, NULL, 1, 'default1'), (3, NULL, NULL, NULL), (4, NULL, 0, 'default1');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (NULL, 1, 1, '2023-01-02'), (1, 2, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, director FROM (SELECT director, COUNT(*) AS n FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) GROUP BY director) ORDER BY count___, director NULLS LAST;

/*
Gold Result:
(1, 'default1')
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID GROUP BY T1.director;

/*
Prediction Result:
(1, None)
(1, 'default1')
*/