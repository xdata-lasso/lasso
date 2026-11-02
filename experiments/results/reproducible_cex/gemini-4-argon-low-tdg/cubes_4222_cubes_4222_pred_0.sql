-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Bravo', 2000, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Alpha', 2001, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Charlie', 2002, 'Dir C');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Delta', 2003, 'Dir D');
INSERT INTO Reviewer (rID, name) VALUES (10, 'Rev 1');
INSERT INTO Reviewer (rID, name) VALUES (20, 'Rev 2');
INSERT INTO Reviewer (rID, name) VALUES (30, 'Rev 3');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 1, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 2, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 2, 4, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 3, 5, '2020-01-05');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 3, 4, '2020-01-06');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 3, 3, '2020-01-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT title, meanstars AS avg_t1_stars_ FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, LHS.meanstars AS meanstars FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.meanstars AS meanstars FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) AS LHS INNER JOIN (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid) AS RHS ON (LHS.mid = RHS.mid)) AS LHS INNER JOIN (SELECT mid, MAX(meanstars) OVER () AS meanstars FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) AS RHS ON (LHS.mid = RHS.mid AND LHS.meanstars = RHS.meanstars)) ORDER BY title, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Alpha', 4.5)
('Bravo', 4.5)
*/

-- Prediction Query
SELECT T2.title, AVG(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID GROUP BY T1.mID ORDER BY AVG(T1.stars) DESC, T2.title NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha', 4.5)
*/