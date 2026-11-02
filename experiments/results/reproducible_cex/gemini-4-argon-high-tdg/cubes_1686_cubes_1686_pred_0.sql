-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Zootopia', 2016, 'Byron Howard');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Up', 2009, 'Pete Docter');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Memento', 2000, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Avatar', 2009, 'James Cameron');
INSERT INTO Reviewer (rID, name) VALUES (10, 'Alice');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 1, 3, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 2, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 3, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 4, 2, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 5, 1, '2020-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars >= 3 OR stars >= 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY title;

/*
Gold Result:
('Memento',)
('Up',)
('Zootopia',)
*/

-- Prediction Query
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID WHERE T1.stars BETWEEN 3 AND 5;

/*
Prediction Result:
('Zootopia',)
('Up',)
('Memento',)
*/