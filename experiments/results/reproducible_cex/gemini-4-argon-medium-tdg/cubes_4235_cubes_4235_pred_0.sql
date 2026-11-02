-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests NULL handling and NULLS LAST vs NULLS FIRST ordering in title, stars, and ratingDate, as well as standard NULL ordering in name.
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Avatar', 2009, 'Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (2, NULL, 2010, 'Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Titanic', NULL, NULL);
INSERT INTO Reviewer (rID, name) VALUES (1, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (2, NULL);
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 1, 4, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 2, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, NULL, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 3, NULL);
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 3, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 3, 2, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, title, stars, ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.name AS name, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.name AS name FROM movie AS LHS CROSS JOIN reviewer AS RHS) AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid AND LHS.rid = RHS.rid)) ORDER BY name, title NULLS LAST, stars NULLS LAST, ratingdate NULLS LAST;

/*
Gold Result:
(None, 'Avatar', 4, '2020-01-01')
('Alice', 'Avatar', 3, '2020-01-02')
('Alice', 'Avatar', 3, None)
('Alice', 'Avatar', None, '2020-01-01')
('Alice', 'Titanic', 2, '2020-01-01')
('Alice', None, 5, '2020-01-01')
*/

-- Prediction Query
SELECT T3.name, T2.title, T1.stars, T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID ORDER BY T3.name, T2.title, T1.stars, T1.rid NULLS LAST, T1.mid NULLS LAST, T1.ratingdate NULLS LAST, T2.mid NULLS LAST, T3.rid NULLS LAST;

/*
Prediction Result:
(None, 'Avatar', 4, '2020-01-01')
('Alice', None, 5, '2020-01-01')
('Alice', 'Avatar', None, '2020-01-01')
('Alice', 'Avatar', 3, '2020-01-02')
('Alice', 'Avatar', 3, None)
('Alice', 'Titanic', 2, '2020-01-01')
*/