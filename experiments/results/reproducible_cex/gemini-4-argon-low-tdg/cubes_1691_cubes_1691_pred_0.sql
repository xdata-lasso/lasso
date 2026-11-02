-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'M1', 2000, 'D1');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'M2', 2001, 'D2');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'M3', 2002, 'D3');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'M4', 2003, 'D4');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'M5', 2004, 'D5');
INSERT INTO Reviewer (rID, name) VALUES (1, 'R1');
INSERT INTO Reviewer (rID, name) VALUES (2, 'R2');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 2, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 2, 1, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 2, 2, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 3, 3, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 4, 4, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mid, meanstars AS avg_stars_ FROM (SELECT mid, meanstars, COUNT(*) OVER () AS n FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) WHERE (meanstars >= 2.0 AND meanstars <= n) ORDER BY mid, avg_stars_ NULLS LAST;

/*
Gold Result:
(1, 2.0)
(3, 3.0)
(4, 4.0)
*/

-- Prediction Query
SELECT mID, AVG(stars) FROM Rating GROUP BY mID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(2, 1.5)
*/