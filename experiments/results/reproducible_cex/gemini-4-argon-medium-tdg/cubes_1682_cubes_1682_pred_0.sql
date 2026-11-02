-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality filter (stars <> 4), boundary values (3, 4, 5), duplicates (SELECT vs SELECT DISTINCT), and ordering by rID.
INSERT INTO Movie (mID, title, year, director) VALUES (101, 'Movie A', 2000, 'Director X');
INSERT INTO Movie (mID, title, year, director) VALUES (102, 'Movie B', 2001, 'Director Y');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (2, 'Bob');
INSERT INTO Reviewer (rID, name) VALUES (3, 'Charlie');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (3, 101, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 101, 3, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 102, 5, '2020-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 101, 4, '2020-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rid FROM rating WHERE (stars <> 4) ORDER BY rid, rating.mid NULLS LAST, rating.stars NULLS LAST, rating.ratingdate NULLS LAST;

/*
Gold Result:
(1,)
(1,)
(3,)
*/

-- Prediction Query
SELECT rID FROM Rating WHERE stars <> 4;

/*
Prediction Result:
(3,)
(1,)
(1,)
*/