-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (0, 'default2'), (1, 'default2'), (2, 'default2'), (3, NULL), (4, 'default2'), (5, 'default2'), (6, NULL), (7, NULL), (8, 'default1'), (9, NULL), (10, 'default1');
INSERT INTO movie (mid, title, year, director) VALUES (0, NULL, 1, 'default1'), (1, 'default2', NULL, 'default2'), (2, 'default1', NULL, 'default1'), (3, 'default1', 0, 'default1'), (4, 'default1', 0, NULL), (5, NULL, 1, 'default2'), (6, NULL, 1, 'default2');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (3, NULL, 0, '2023-01-01'), (10, 5, 0, '2023-01-02'), (5, 6, 1, NULL), (5, NULL, NULL, '2023-01-02'), (8, 5, NULL, NULL), (NULL, 3, NULL, NULL), (7, 2, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, title, stars, ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, LHS.rid AS rid, LHS.name AS name, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.name AS name FROM movie AS LHS CROSS JOIN reviewer AS RHS) AS LHS INNER JOIN rating AS RHS ON (LHS.mid = RHS.mid AND LHS.rid = RHS.rid)) ORDER BY name, title NULLS LAST, stars NULLS LAST, ratingdate NULLS LAST;

/*
Gold Result:
(None, 'default1', 1, '2023-01-01')
('default1', None, 0, '2023-01-02')
('default1', None, None, None)
('default2', None, 1, None)
*/

-- Prediction Query
SELECT T3.name, T2.title, T1.stars, T1.ratingDate FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID ORDER BY T3.name, T2.title, T1.stars, T1.rid NULLS LAST, T1.mid NULLS LAST, T1.ratingdate NULLS LAST, T2.mid NULLS LAST, T3.rid NULLS LAST;

/*
Prediction Result:
(None, 'default1', 1, '2023-01-01')
('default1', None, None, None)
('default1', None, 0, '2023-01-02')
('default2', None, 1, None)
*/