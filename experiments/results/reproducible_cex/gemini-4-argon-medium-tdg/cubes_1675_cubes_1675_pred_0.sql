-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Movie (mID, title, year, director) VALUES (50, 'Beta', 2015, 'D2');
INSERT INTO Reviewer (rID, name) VALUES (5, 'SingleValid');
-- Rating with NULL rID and stars = 4 (kills NOT IN (SELECT rID FROM Rating WHERE stars = 4) when NULLs exist)
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (NULL, 50, 4, '2023-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (5, 50, 2, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rid FROM (SELECT * FROM rating AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM rating WHERE (stars = 4)) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY rid;

/*
Gold Result:
(None,)
(5,)
*/

-- Prediction Query
SELECT rID FROM Rating EXCEPT SELECT rID FROM Rating WHERE stars = 4;

/*
Prediction Result:
(5,)
*/