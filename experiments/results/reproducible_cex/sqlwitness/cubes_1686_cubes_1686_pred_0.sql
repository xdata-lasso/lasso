-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (0, NULL), (2, 'default1'), (3, 'default2'), (4, NULL), (1, 'default1'), (5, 'default2'), (6, 'default1'), (7, 'default2'), (8, 'default2'), (9, 'default2'), (10, 'default2'), (11, NULL), (12, 'default2');
INSERT INTO movie (mid, title, year, director) VALUES (3, NULL, 6, 'default2'), (6, 'default2', 4, 'default2'), (0, 'default2', 6, NULL), (4, NULL, 2, 'default2'), (1, NULL, 5, 'default2'), (2, 'default1', 0, NULL);
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (NULL, 4, 5, '2023-01-01'), (1, 4, 6, NULL), (NULL, 3, 4, '2023-01-01'), (12, 3, 4, '2023-01-01'), (1, NULL, 3, '2023-01-02'), (2, NULL, 6, '2023-01-02'), (7, 3, 1, '2023-01-01'), (4, 4, 0, '2023-01-02'), (7, NULL, NULL, NULL), (4, 6, NULL, '2023-01-01'), (12, 2, 4, '2023-01-02'), (1, NULL, 6, '2023-01-02'), (1, NULL, 6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars >= 3 OR stars >= 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY title;

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID WHERE T1.stars BETWEEN 3 AND 5;

/*
Prediction Result:
(None,)
(None,)
(None,)
('default1',)
*/