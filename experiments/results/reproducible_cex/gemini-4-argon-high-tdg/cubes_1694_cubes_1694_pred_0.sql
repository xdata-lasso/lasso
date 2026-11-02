-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (101, 'Film A', 2000, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (102, 'Film B', 2001, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (103, 'Film C', 2002, 'Dir C');
INSERT INTO Movie (mID, title, year, director) VALUES (104, 'Film D', 2003, 'Dir D');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Zoe');
INSERT INTO Reviewer (rID, name) VALUES (2, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (3, 'Bob');
INSERT INTO Reviewer (rID, name) VALUES (4, 'Charlie');
INSERT INTO Reviewer (rID, name) VALUES (5, 'David');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 101, 4, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 102, 5, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 103, 2, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 101, 3, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 102, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (3, 101, 1, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (3, 102, 2, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (3, 104, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 101, 4, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 102, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 103, 4, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 104, 4, '2020-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.n AS n FROM reviewer AS LHS INNER JOIN (SELECT * FROM (SELECT rid, COUNT(*) AS n FROM rating GROUP BY rid) WHERE (n = 3)) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
('Bob',)
('Zoe',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T1.rID HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Zoe',)
('Bob',)
('Charlie',)
*/