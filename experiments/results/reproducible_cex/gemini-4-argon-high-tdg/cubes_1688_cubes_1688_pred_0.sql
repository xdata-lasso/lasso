-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (10, 'Gone with the Wind', 1939, 'Victor Fleming');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (20, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Reviewer" ("rID", "name") VALUES (10, 'TrapSameID');
INSERT INTO "Reviewer" ("rID", "name") VALUES (20, 'Zoe');
INSERT INTO "Reviewer" ("rID", "name") VALUES (30, 'Alice');
INSERT INTO "Reviewer" ("rID", "name") VALUES (40, 'UnratedUser');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 20, 5, '2021-05-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (20, 10, 4, '2021-05-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (30, 10, 5, '2021-05-03');
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