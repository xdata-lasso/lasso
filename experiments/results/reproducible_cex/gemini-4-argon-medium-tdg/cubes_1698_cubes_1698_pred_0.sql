-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests OR vs AND, > 2000 vs >= 2000, INNER JOIN vs LEFT JOIN (unrated movies), and ordering
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Zebra', 1995, 'Dir A');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Alpha', 2001, 'Dir B');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Beta', 2000, 'Dir C');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Gamma', 2005, 'Dir D');
INSERT INTO "Reviewer" ("rID", "name") VALUES (10, 'Brittany Harris');
INSERT INTO "Reviewer" ("rID", "name") VALUES (20, 'John Doe');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 1, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (20, 2, 4, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (20, 3, 3, '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "title" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Brittany Harris' OR YEAR > 2000) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT DISTINCT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Brittany Harris' OR T2.year > 2000;

/*
Prediction Result:
('Zebra',)
('Alpha',)
*/