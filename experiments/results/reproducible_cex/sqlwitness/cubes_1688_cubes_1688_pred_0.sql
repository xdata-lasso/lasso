-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (0, 'default1'), (1, 'Gone with the Wind'), (2, 'Gone with the Wind'), (3, NULL), (4, 'default1'), (5, 'Gone with the Wind'), (6, 'default1'), (7, 'default2'), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, 'default1'), (13, 'Gone with the Wind'), (14, NULL), (15, NULL), (16, 'default2');
INSERT INTO movie (mid, title, year, director) VALUES (1, 'default1', 0, 'Gone with the Wind'), (0, NULL, 0, 'Gone with the Wind'), (2, 'Gone with the Wind', 0, 'Gone with the Wind'), (3, 'default2', NULL, NULL), (4, 'Gone with the Wind', 0, 'default1'), (5, NULL, NULL, 'Gone with the Wind'), (6, 'default2', 0, 'default2'), (7, 'default1', 1, 'default2'), (8, 'default2', NULL, 'Gone with the Wind'), (9, 'default1', 0, 'default2'), (10, 'default2', 0, NULL), (11, 'Gone with the Wind', 1, 'default1'), (12, 'default1', NULL, 'Gone with the Wind'), (13, 'default2', 0, 'Gone with the Wind'), (14, NULL, 1, 'default1'), (15, 'Gone with the Wind', 0, 'default1'), (16, 'Gone with the Wind', 1, 'default2'), (17, NULL, 0, NULL), (18, NULL, 0, NULL), (19, 'default2', NULL, 'default2');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (6, 12, 0, '2023-01-02'), (1, 6, 1, NULL), (13, 2, 1, '2023-01-01'), (0, 16, 1, '2023-01-01'), (10, 8, 0, NULL), (5, 5, 0, '2023-01-01'), (9, 2, NULL, '2023-01-02'), (14, 2, NULL, '2023-01-01'), (9, 5, NULL, '2023-01-02'), (9, NULL, NULL, NULL), (9, 14, 1, '2023-01-02'), (7, 5, NULL, NULL), (1, 11, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("title" = 'Gone with the Wind') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Gone with the Wind',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T3.name FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T2.title = 'Gone with the Wind';

/*
Prediction Result:
('Gone with the Wind',)
('default1',)
('default2',)
(None,)
*/