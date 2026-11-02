-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Alpha', 2000, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Beta', 2005, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Gamma', 2010, 'Dir C');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Charlie');
INSERT INTO Reviewer (rID, name) VALUES (2, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (3, 'Bob');
INSERT INTO Reviewer (rID, name) VALUES (4, 'David');
INSERT INTO Reviewer (rID, name) VALUES (5, 'Eve');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 3, 4, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (3, 2, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 1, 3, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 2, 2, '2020-01-05');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (4, 3, NULL, '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.mid AS mid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.name AS name FROM (SELECT * FROM rating WHERE (stars > 3)) AS LHS LEFT JOIN reviewer AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T1.stars > 3;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Bob',)
*/