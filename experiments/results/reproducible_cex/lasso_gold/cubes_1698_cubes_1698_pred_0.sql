-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1058, 'Psychiatric nurse', 2001, 'not');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1064, 'Multimedia specialist', 2001, 'bar');
INSERT INTO "reviewer" ("rid", "name") VALUES (1059, 'Brittany Harris');
INSERT INTO "reviewer" ("rid", "name") VALUES (1065, 'Brittany Harris');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1059, 1058, 1060, '1988-08-19');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1059, 1058, 1063, '1989-09-20');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1065, 1064, 1066, '1990-10-21');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "title" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Brittany Harris' OR YEAR > 2000) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Multimedia specialist',)
('Psychiatric nurse',)
*/

-- Prediction Query
SELECT DISTINCT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Brittany Harris' OR T2.year > 2000;

/*
Prediction Result:
('Psychiatric nurse',)
('Multimedia specialist',)
*/