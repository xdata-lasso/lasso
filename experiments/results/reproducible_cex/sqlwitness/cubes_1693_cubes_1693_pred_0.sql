-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (2, 'default2'), (3, NULL), (4, 'default2');
INSERT INTO movie (mid, title, year, director) VALUES (4, 'default2', 0, NULL), (1, 'default2', 2, NULL), (0, 'default2', 0, NULL), (3, 'default2', NULL, NULL), (2, NULL, 4, 'default1'), (5, 'default2', 2, 'default2');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (4, 5, 3, NULL), (NULL, 1, 3, '2023-01-02'), (NULL, 4, 4, '2023-01-02'), (NULL, 5, 4, NULL), (3, 5, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.mid AS mid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.name AS name FROM (SELECT * FROM rating WHERE (stars > 3)) AS LHS LEFT JOIN reviewer AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T1.stars > 3;

/*
Prediction Result:
*/