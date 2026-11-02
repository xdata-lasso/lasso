-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (0, 'default2'), (6, 'default1'), (1, NULL), (5, 'default2'), (4, 'default1'), (2, NULL), (3, 'default2'), (7, 'default1'), (8, 'default2'), (9, NULL), (10, NULL), (11, 'default1'), (12, 'default1'), (13, 'default2');
INSERT INTO movie (mid, title, year, director) VALUES (1, 'default2', 0, 'default2'), (4, 'default2', NULL, 'default1'), (0, 'default1', 4, NULL), (5, 'default2', 4, 'default2'), (6, NULL, 4, 'default1'), (2, 'default1', 0, 'default2'), (3, 'default1', 0, NULL), (7, 'default2', 5, 'default1'), (8, 'default1', 5, 'default2'), (9, 'default1', 1, 'default1'), (10, NULL, 5, 'default2'), (11, 'default2', 0, 'default1'), (12, 'default1', NULL, 'default1');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (8, 1, 1, NULL), (2, 11, 5, '2023-01-02'), (5, 0, 5, '2023-01-01'), (13, 10, NULL, '2023-01-02'), (13, 5, 1, NULL), (11, 11, NULL, '2023-01-01'), (11, 4, 1, NULL), (7, 9, 0, '2023-01-02'), (13, 4, 6, '2023-01-01'), (4, 1, NULL, '2023-01-02'), (6, 1, 1, '2023-01-01'), (12, 5, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director, title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars = 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY director, title NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default1', 'default2')
*/

-- Prediction Query
SELECT T1.director, T1.title FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID WHERE T2.stars = 5;

/*
Prediction Result:
('default1', 'default2')
(None, 'default1')
*/