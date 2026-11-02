-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (4, NULL), (2, NULL);
INSERT INTO movie (mid, title, year, director) VALUES (4, 'default2', NULL, NULL), (1, 'default2', 0, 'default2'), (2, 'default2', 3, NULL), (3, 'default2', 3, 'default1'), (0, 'default2', 3, NULL), (5, NULL, 1, 'default1'), (6, 'default2', 1, NULL), (7, NULL, NULL, NULL), (8, NULL, 0, 'default2'), (9, 'default1', 4, 'default2'), (10, 'default1', 3, 'default2'), (11, 'default2', 1, NULL);
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (NULL, 8, 3, '2023-01-01'), (4, 11, 0, NULL), (4, 0, 0, '2023-01-01'), (4, 0, 3, '2023-01-02'), (2, 0, 4, '2023-01-02'), (4, 6, 0, '2023-01-02'), (4, 4, 4, NULL), (NULL, 2, 0, '2023-01-01'), (2, 0, 3, NULL), (4, 0, 3, '2023-01-01'), (4, 1, 2, '2023-01-01'), (4, 0, 2, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.n AS n FROM reviewer AS LHS INNER JOIN (SELECT * FROM (SELECT rid, COUNT(*) AS n FROM rating GROUP BY rid) WHERE (n = 3)) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T1.rID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None,)
*/