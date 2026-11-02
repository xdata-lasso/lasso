-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Alpha', 1999, 'Dir1');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Beta', 1999, 'Dir2');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Alpha', 1995, 'Dir1');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Gamma', 2000, 'Dir3');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Delta', 2001, 'Dir4');
INSERT INTO Movie (mID, title, year, director) VALUES (6, NULL, 1980, NULL);
INSERT INTO Movie (mID, title, year, director) VALUES (7, 'Epsilon', NULL, 'Dir5');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Alice');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 4, 3, '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT YEAR) AS n_distinct FROM (SELECT * FROM movie WHERE (YEAR < 2000))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Movie WHERE YEAR < 2000;

/*
Prediction Result:
(4,)
*/