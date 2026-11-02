-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A', 2001, 'Charlie');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Movie B', 2002, 'Bob');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Movie C', 2003, 'Bob');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Movie D', 2004, 'Bob');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Movie E', 2005, 'Alice');
INSERT INTO Movie (mID, title, year, director) VALUES (6, 'Movie F', 2006, NULL);
INSERT INTO Movie (mID, title, year, director) VALUES (7, 'Movie G', 2007, NULL);
INSERT INTO Movie (mID, title, year, director) VALUES (8, 'Movie H', 2008, 'David');
INSERT INTO Movie (mID, title, year, director) VALUES (9, 'Movie I', 2009, 'Eve');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Rev 1');
INSERT INTO Reviewer (rID, name) VALUES (102, 'Rev 2');
INSERT INTO Reviewer (rID, name) VALUES (103, 'Rev 3');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 1, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (103, 1, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 2, 4, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 3, 5, '2020-01-05');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 5, 4, '2020-01-06');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (103, 5, 5, '2020-01-07');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 6, 4, '2020-01-08');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 7, 5, '2020-01-09');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (103, 8, 5, '2020-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, director FROM (SELECT director, COUNT(*) AS n FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) GROUP BY director) ORDER BY count___, director NULLS LAST;

/*
Gold Result:
(1, 'David')
(2, 'Alice')
(2, 'Bob')
(2, None)
(3, 'Charlie')
*/

-- Prediction Query
SELECT COUNT(*), T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID GROUP BY T1.director;

/*
Prediction Result:
(2, None)
(2, 'Alice')
(2, 'Bob')
(3, 'Charlie')
(1, 'David')
*/