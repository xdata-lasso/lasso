-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (NULL, NULL, 2, NULL), (NULL, NULL, 4, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT rid FROM (SELECT * FROM rating AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM rating WHERE (stars = 4)) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY rid;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT rID FROM Rating EXCEPT SELECT rID FROM Rating WHERE stars = 4;

/*
Prediction Result:
*/