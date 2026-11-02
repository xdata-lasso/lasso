-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A', 2020, 'Director 1');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Movie B', 2021, 'Director 2');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Reviewer 1');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 5, '2023-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 2, 5, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT title, meanstars AS avg_t1_stars_ FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, LHS.meanstars AS meanstars FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.meanstars AS meanstars FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) AS LHS INNER JOIN (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid) AS RHS ON (LHS.mid = RHS.mid)) AS LHS INNER JOIN (SELECT mid, MAX(meanstars) OVER () AS meanstars FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) AS RHS ON (LHS.mid = RHS.mid AND LHS.meanstars = RHS.meanstars)) ORDER BY title, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Movie A', 5.0)
('Movie B', 5.0)
*/

-- Prediction Query
SELECT T2.title, AVG(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID GROUP BY T1.mID ORDER BY AVG(T1.stars) DESC, T2.title NULLS LAST LIMIT 1;

/*
Prediction Result:
('Movie A', 5.0)
*/