-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests reviewers with identical names (GROUP BY rID vs GROUP BY name, DISTINCT mutations, and secondary ORDER BY avg_t1_stars_).
INSERT INTO Movie (mID, title, year, director) VALUES (101, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (102, 'Avatar', 2009, 'James Cameron');
INSERT INTO Reviewer (rID, name) VALUES (201, 'Chris Jackson');
INSERT INTO Reviewer (rID, name) VALUES (202, 'Chris Jackson');
INSERT INTO Reviewer (rID, name) VALUES (203, 'Chris Jackson');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (201, 101, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (201, 102, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (202, 101, 2, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (203, 101, 5, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (203, 102, 4, '2020-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Chris Jackson', 2.0)
('Chris Jackson', 4.5)
('Chris Jackson', 4.5)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('Chris Jackson', 4.0)
*/