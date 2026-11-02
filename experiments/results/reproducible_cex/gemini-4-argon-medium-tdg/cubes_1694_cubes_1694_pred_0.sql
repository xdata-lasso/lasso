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
INSERT INTO Reviewer (rID, name) VALUES (10, 'ZeroRatings');
INSERT INTO Reviewer (rID, name) VALUES (20, 'TwoRatings');
INSERT INTO Reviewer (rID, name) VALUES (30, 'FourRatings');
INSERT INTO Reviewer (rID, name) VALUES (40, 'Zack');
INSERT INTO Reviewer (rID, name) VALUES (50, 'Alice');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 2, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 2, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 3, 3, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 4, 2, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 2, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 3, 3, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (50, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (50, 2, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (50, 3, 3, '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.n AS n FROM reviewer AS LHS INNER JOIN (SELECT * FROM (SELECT rid, COUNT(*) AS n FROM rating GROUP BY rid) WHERE (n = 3)) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T1.rID HAVING COUNT(*) >= 3;

/*
Prediction Result:
('FourRatings',)
('Zack',)
('Alice',)
*/