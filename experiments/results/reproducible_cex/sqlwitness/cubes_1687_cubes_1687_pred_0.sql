-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (0, NULL), (1, NULL), (2, 'default2'), (3, 'Sarah Martinez'), (4, 'default2'), (5, NULL), (6, 'default2'), (7, 'default2'), (8, NULL), (9, NULL), (10, 'Sarah Martinez');
INSERT INTO movie (mid, title, year, director) VALUES (0, 'Sarah Martinez', 1, 'Sarah Martinez'), (1, 'Sarah Martinez', NULL, 'Sarah Martinez'), (2, 'default2', 0, 'Sarah Martinez'), (3, 'default1', 0, 'default1');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (1, NULL, 0, NULL), (2, NULL, 0, '2023-01-02'), (0, NULL, 0, NULL), (3, 3, 0, '2023-01-01'), (5, NULL, 1, NULL), (1, NULL, 1, '2023-01-02'), (4, 1, 1, '2023-01-01'), (8, NULL, NULL, NULL), (0, 0, 0, NULL), (5, NULL, NULL, '2023-01-02'), (4, 2, NULL, '2023-01-02'), (NULL, 1, 1, '2023-01-02'), (1, 0, NULL, '2023-01-01'), (10, 0, 0, '2023-01-02'), (1, 2, 1, NULL), (NULL, 3, NULL, '2023-01-01'), (NULL, 3, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "director" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM "movie" AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid")) AS "LHS" INNER JOIN (SELECT * FROM "reviewer" WHERE ("name" = 'Sarah Martinez')) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY director, "director" NULLS LAST;

/*
Gold Result:
('Sarah Martinez',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T2.director FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Sarah Martinez';

/*
Prediction Result:
('default1',)
('Sarah Martinez',)
*/