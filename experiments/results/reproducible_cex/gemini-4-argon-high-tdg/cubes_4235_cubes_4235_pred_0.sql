-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (2, NULL, 2012, NULL);
INSERT INTO Reviewer (rID, name) VALUES (1, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (2, NULL);
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 1, 5, '2022-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 2, 3, '2022-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, NULL, '2022-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 4, NULL);
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 4, '2022-05-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, title, stars, ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.name AS name, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.name AS name FROM movie AS LHS CROSS JOIN reviewer AS RHS) AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid AND LHS.rid = RHS.rid)) ORDER BY name, title NULLS LAST, stars NULLS LAST, ratingdate NULLS LAST;

/*
Gold Result:
(None, 'Inception', 5, '2022-01-01')
('Alice', 'Inception', 4, '2022-05-10')
('Alice', 'Inception', 4, None)
('Alice', 'Inception', None, '2022-01-01')
('Alice', None, 3, '2022-01-01')
*/

-- Prediction Query
SELECT T3.name, T2.title, T1.stars, T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID ORDER BY T3.name, T2.title, T1.stars, T1.rid NULLS LAST, T1.mid NULLS LAST, T1.ratingdate NULLS LAST, T2.mid NULLS LAST, T3.rid NULLS LAST;

/*
Prediction Result:
(None, 'Inception', 5, '2022-01-01')
('Alice', None, 3, '2022-01-01')
('Alice', 'Inception', None, '2022-01-01')
('Alice', 'Inception', 4, '2022-05-10')
('Alice', 'Inception', 4, None)
*/