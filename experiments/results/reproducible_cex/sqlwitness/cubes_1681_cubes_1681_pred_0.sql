-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (1, 'default1'), (0, 'default1'), (2, 'default1'), (3, 'default1');
INSERT INTO movie (mid, title, year, director) VALUES (0, 'default1', NULL, 'default1'), (1, 'default1', 0, NULL), (2, NULL, 0, 'default2'), (3, 'default2', 1, 'default2'), (4, NULL, 1, NULL), (5, 'default2', 0, NULL);
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (3, 1, 0, '2023-01-02'), (3, 4, NULL, '2023-01-02'), (1, 0, NULL, '2023-01-01'), (3, 5, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('default1', 0.0)
('default1', None)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('default1', 0.0)
*/