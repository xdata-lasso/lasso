-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A', 2000, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Movie B', 2001, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Movie C', 2002, 'Dir C');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Movie D', 2003, 'Dir D');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Rev 1');
INSERT INTO Reviewer (rID, name) VALUES (102, 'Rev 2');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 2, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 2, 3, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 3, 4, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 3, 4, '2020-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mid, meanstars AS avg_stars_ FROM (SELECT mid, meanstars, COUNT(*) OVER () AS n FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) WHERE (meanstars >= 2.0 AND meanstars <= n) ORDER BY mid, avg_stars_ NULLS LAST;

/*
Gold Result:
(1, 2.0)
(2, 3.0)
*/

-- Prediction Query
SELECT mID, AVG(stars) FROM Rating GROUP BY mID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(3, 4.0)
*/