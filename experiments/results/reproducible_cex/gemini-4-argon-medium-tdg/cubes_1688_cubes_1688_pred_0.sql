-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join conditions, WHERE filter on 'title', and ORDER BY 'name'
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Gone with the Wind', 1939, 'Victor Fleming');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Star Wars', 1977, 'George Lucas');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, NULL, 2000, 'Unknown');
INSERT INTO "Reviewer" ("rID", "name") VALUES (101, 'Zoe');
INSERT INTO "Reviewer" ("rID", "name") VALUES (102, 'Alice');
INSERT INTO "Reviewer" ("rID", "name") VALUES (103, 'Bob');
INSERT INTO "Reviewer" ("rID", "name") VALUES (104, 'Charlie');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 1, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (102, 1, 4, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (103, 2, 3, '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("title" = 'Gone with the Wind') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT T3.name FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T2.title = 'Gone with the Wind';

/*
Prediction Result:
('Zoe',)
('Alice',)
*/