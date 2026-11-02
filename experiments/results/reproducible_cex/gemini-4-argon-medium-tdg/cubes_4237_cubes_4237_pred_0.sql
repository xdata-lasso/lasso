-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. INNER JOIN vs LEFT JOIN (Unrated movie 'Movie D' must be excluded).
-- 2. COUNT(*) vs COUNT(director) vs COUNT(ratingDate) vs COUNT(stars) (NULL director, NULL ratingDate, NULL stars).
-- 3. COUNT(*) vs COUNT(DISTINCT mID) vs COUNT(DISTINCT rID) (Same movie rated multiple times, same reviewer rating multiple times).
-- 4. ORDER BY count___ ASC, director ASC NULLS LAST (Ties in count, including NULL director tie-breaking).
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A1', 2000, 'Zack');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Movie A2', 2002, 'Zack');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Movie B', 2005, 'Alan');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Movie C', 2010, NULL);
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Movie D', 2015, 'Unrated');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Rev 1');
INSERT INTO Reviewer (rID, name) VALUES (102, 'Rev 2');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 2, 4, NULL);
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 2, NULL, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 3, 3, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 3, 5, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 4, 2, '2020-01-05');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 4, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, director FROM (SELECT director, COUNT(*) AS n FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) GROUP BY director) ORDER BY count___, director NULLS LAST;

/*
Gold Result:
(2, 'Alan')
(2, None)
(3, 'Zack')
*/

-- Prediction Query
SELECT COUNT(*), T1.director FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID GROUP BY T1.director;

/*
Prediction Result:
(2, None)
(2, 'Alan')
(3, 'Zack')
*/