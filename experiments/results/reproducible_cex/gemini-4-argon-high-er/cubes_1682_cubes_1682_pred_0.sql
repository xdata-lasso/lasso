-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A', 2000, 'Director A');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Reviewer 1');
INSERT INTO Reviewer (rID, name) VALUES (2, 'Reviewer 2');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 1, 3, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 3, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rid FROM rating WHERE (stars <> 4) ORDER BY rid, rating.mid NULLS LAST, rating.stars NULLS LAST, rating.ratingdate NULLS LAST;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT rID FROM Rating WHERE stars <> 4;

/*
Prediction Result:
(2,)
(1,)
*/