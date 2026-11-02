-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Zootopia', 2016, 'Byron Howard');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Arrival', 2016, 'Denis Villeneuve');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Memento', 2000, 'Christopher Nolan');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Critic One');
INSERT INTO Reviewer (rID, name) VALUES (2, 'Critic Two');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 5, '2021-03-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 1, 4, '2021-03-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 2, 4, '2021-03-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 2, 5, '2021-03-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 3, 4, '2021-03-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT title, meanstars AS avg_t1_stars_ FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, LHS.meanstars AS meanstars FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.meanstars AS meanstars FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid)) AS LHS INNER JOIN (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid) AS RHS ON (LHS.mid = RHS.mid)) AS LHS INNER JOIN (SELECT mid, MAX(meanstars) OVER () AS meanstars FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) AS RHS ON (LHS.mid = RHS.mid AND LHS.meanstars = RHS.meanstars)) ORDER BY title, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Arrival', 4.5)
('Zootopia', 4.5)
*/

-- Prediction Query
SELECT T2.title, AVG(T1.stars) FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID GROUP BY T1.mID ORDER BY AVG(T1.stars) DESC, T2.title NULLS LAST LIMIT 1;

/*
Prediction Result:
('Arrival', 4.5)
*/