-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie Two', 2000, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Movie Three', 2001, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Movie Four', 2002, 'Dir C');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Movie Five', 2003, 'Dir D');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Movie Six', 2004, 'Dir E');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Rev 1');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 2, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 2, 3, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 3, 4, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 4, 5, '2020-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 5, 6, '2020-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars >= 3 OR stars >= 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY title;

/*
Gold Result:
('Movie Five',)
('Movie Four',)
('Movie Six',)
('Movie Three',)
*/

-- Prediction Query
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID WHERE T1.stars BETWEEN 3 AND 5;

/*
Prediction Result:
('Movie Three',)
('Movie Four',)
('Movie Five',)
*/