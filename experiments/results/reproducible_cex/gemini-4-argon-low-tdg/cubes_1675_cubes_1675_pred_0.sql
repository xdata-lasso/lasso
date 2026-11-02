-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Movie (mID, title, year, director) VALUES (50, 'Film X', 2010, 'Dir X');
INSERT INTO Reviewer (rID, name) VALUES (5, 'Rev 5');
INSERT INTO Reviewer (rID, name) VALUES (6, 'Rev 6');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (5, 50, 4, '2022-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (5, 50, NULL, '2022-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (6, 50, 3, '2022-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (6, 50, NULL, '2022-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (NULL, 50, 4, '2022-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rid FROM (SELECT * FROM rating AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM rating WHERE (stars = 4)) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY rid;

/*
Gold Result:
(None,)
(6,)
*/

-- Prediction Query
SELECT rID FROM Rating EXCEPT SELECT rID FROM Rating WHERE stars = 4;

/*
Prediction Result:
(6,)
*/