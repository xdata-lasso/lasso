-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling, duplicates, and ordering:
-- 1. Multiple movies with the exact same title (kills SELECT DISTINCT or GROUP BY title mutants).
-- 2. Movie with a NULL title (kills ORDER BY NULLS FIRST vs NULLS LAST mutants and tests NULL projection).
-- 3. Rating with NULL mID or NULL rID (kills NOT IN (SELECT mID ...) mutants if NULLs are introduced in subqueries).
-- 4. Reviewer with NULL name.
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Duplicate Title', 1995, 'Dir X');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Duplicate Title', 2010, 'Dir Y');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, NULL, 2015, 'Dir Z');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Alpha', 2020, 'Dir W');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Chris Jackson');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, NULL);
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, NULL, 3, '2021-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (NULL, 1, 4, '2021-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 2, 5, '2021-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM "movie" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."rid" AS "rid", "LHS"."mid" AS "mid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM "rating" AS "LHS" LEFT JOIN "reviewer" AS "RHS" ON ("LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Chris Jackson')) AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Duplicate Title',)
('Duplicate Title',)
*/

-- Prediction Query
SELECT DISTINCT title FROM Movie EXCEPT SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Chris Jackson';

/*
Prediction Result:
(None,)
('Alpha',)
('Duplicate Title',)
*/