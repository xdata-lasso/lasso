-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (101, 'Alpha', 2001, 'Dir A');
INSERT INTO Movie (mID, title, year, director) VALUES (102, 'Beta', 2002, 'Dir B');
INSERT INTO Movie (mID, title, year, director) VALUES (103, 'Gamma', 2003, 'Dir C');
INSERT INTO Movie (mID, title, year, director) VALUES (104, 'Delta', 2004, 'Dir D');
INSERT INTO Movie (mID, title, year, director) VALUES (105, 'Epsilon', 2005, 'Dir E');
INSERT INTO Reviewer (rID, name) VALUES (10, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (20, 'Bob');
INSERT INTO Reviewer (rID, name) VALUES (30, 'Charlie');
INSERT INTO Reviewer (rID, name) VALUES (40, 'Diana');
INSERT INTO Reviewer (rID, name) VALUES (50, 'Evan');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 101, 1, '2023-05-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 104, 4, '2023-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (50, 102, 3, '2023-02-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 105, 5, '2023-04-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 103, 2, '2023-03-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 101, 3, '2023-01-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rid FROM rating WHERE (stars <> 4) ORDER BY rid, rating.mid NULLS LAST, rating.stars NULLS LAST, rating.ratingdate NULLS LAST;

/*
Gold Result:
(10,)
(10,)
(30,)
(40,)
(50,)
*/

-- Prediction Query
SELECT rID FROM Rating WHERE stars <> 4;

/*
Prediction Result:
(40,)
(50,)
(10,)
(30,)
(10,)
*/