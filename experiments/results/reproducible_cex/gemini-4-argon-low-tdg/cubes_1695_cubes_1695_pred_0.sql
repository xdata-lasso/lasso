-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Zebra', 2020, 'Director A');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Apple', 2020, 'Director B');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Mango', 2010, 'Director C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.mid AS mid_other, RHS.director AS director_other FROM (SELECT mid, title, MAX(YEAR) OVER () AS YEAR, director FROM movie) AS LHS INNER JOIN movie AS RHS ON (LHS.title = RHS.title AND LHS.year = RHS.year)) ORDER BY title;

/*
Gold Result:
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR = (SELECT MAX(YEAR) FROM Movie);

/*
Prediction Result:
('Zebra',)
('Apple',)
*/