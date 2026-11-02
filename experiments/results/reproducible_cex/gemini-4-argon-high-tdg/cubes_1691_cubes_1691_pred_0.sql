-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (10, 'Alpha', 2001, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (20, 'Beta', 2002, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (30, 'Gamma', 2003, 'Dir C');
INSERT INTO Movie (mID, title, year, director) VALUES (40, 'Delta', 2004, 'Dir D');
INSERT INTO Movie (mID, title, year, director) VALUES (50, 'Epsilon', 2005, 'Dir E');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (2, 'Bob');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 30, 2, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 30, 2, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 10, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 10, 5, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 40, 1, '2020-01-05');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 40, 2, '2020-01-06');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 20, 2, '2020-01-07');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 20, 3, '2020-01-08');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 50, 6, '2020-01-09');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 50, 6, '2020-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mid, meanstars AS avg_stars_ FROM (SELECT mid, meanstars, COUNT(*) OVER () AS n FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) WHERE (meanstars >= 2.0 AND meanstars <= n) ORDER BY mid, avg_stars_ NULLS LAST;

/*
Gold Result:
(10, 5.0)
(20, 2.5)
(30, 2.0)
*/

-- Prediction Query
SELECT mID, AVG(stars) FROM Rating GROUP BY mID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(10, 5.0)
(20, 2.5)
(30, 2.0)
(40, 1.5)
(50, 6.0)
*/