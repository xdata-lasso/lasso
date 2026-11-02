-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Titanic', 1997, 'James Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Avatar', 2009, 'James Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Jaws', 1975, 'Steven Spielberg');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Alien', 1979, 'Ridley Scott');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Gladiator', 2000, 'Ridley Scott');
INSERT INTO Movie (mID, title, year, director) VALUES (6, 'Unrated Movie', 2020, 'Aaron Sorkin');
INSERT INTO Reviewer (rID, name) VALUES (10, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (20, 'Bob');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 1, 5, '2023-01-10');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 2, 5, '2023-01-11');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 3, 5, '2023-01-12');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 4, 4, '2023-01-13');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 5, 6, '2023-01-14');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 5, NULL, '2023-01-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director, title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars = 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY director, title NULLS LAST;

/*
Gold Result:
('James Cameron', 'Avatar')
('James Cameron', 'Titanic')
('Steven Spielberg', 'Jaws')
*/

-- Prediction Query
SELECT T1.director, T1.title FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID WHERE T2.stars = 5;

/*
Prediction Result:
('James Cameron', 'Titanic')
('James Cameron', 'Avatar')
('Steven Spielberg', 'Jaws')
*/