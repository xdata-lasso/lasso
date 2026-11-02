-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests ORDER BY director, title NULLS LAST with ties, varying sort orders, and NULL values in both director and title.
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Zebra', 1990, 'Alpha');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Apple', 1995, 'Alpha');
INSERT INTO Movie (mID, title, year, director) VALUES (3, NULL, 2000, 'Alpha');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Mango', 2005, 'Beta');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Banana', 2010, NULL);
INSERT INTO Movie (mID, title, year, director) VALUES (6, NULL, 2015, NULL);
INSERT INTO Reviewer (rID, name) VALUES (301, 'Critic');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (301, 1, 5, '2022-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (301, 2, 5, '2022-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (301, 3, 5, '2022-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (301, 4, 5, '2022-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (301, 5, 5, '2022-01-05');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (301, 6, 5, '2022-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director, title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars = 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY director, title NULLS LAST;

/*
Gold Result:
(None, 'Banana')
(None, None)
('Alpha', 'Apple')
('Alpha', 'Zebra')
('Alpha', None)
('Beta', 'Mango')
*/

-- Prediction Query
SELECT T1.director, T1.title FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID WHERE T2.stars = 5;

/*
Prediction Result:
('Alpha', 'Zebra')
('Alpha', 'Apple')
('Alpha', None)
('Beta', 'Mango')
(None, 'Banana')
(None, None)
*/