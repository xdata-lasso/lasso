-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A', 2000, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Movie B', 2005, 'Dir B');
INSERT INTO Reviewer (rID, name) VALUES (10, 'Charlie');
INSERT INTO Reviewer (rID, name) VALUES (20, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (30, 'Bob');
INSERT INTO Reviewer (rID, name) VALUES (40, 'Alice');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 2, 2, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 1, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 1, 2, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 2, 2, '2020-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Alice', 2.0)
('Alice', 5.0)
('Charlie', 3.5)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('Alice', 3.0)
('Charlie', 3.5)
*/