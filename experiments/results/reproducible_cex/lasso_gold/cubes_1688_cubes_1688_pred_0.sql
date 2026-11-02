-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1099, 'Gone with the Wind', 1100, 'Mr');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1103, 'Gone with the Wind', 1104, 'collection');
INSERT INTO "reviewer" ("rid", "name") VALUES (1101, 'Zachary Rice');
INSERT INTO "reviewer" ("rid", "name") VALUES (1105, 'Peter Callahan Jr.');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1101, 1099, 1102, '1994-03-02');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1105, 1103, 1106, '1995-04-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("title" = 'Gone with the Wind') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Peter Callahan Jr.',)
('Zachary Rice',)
*/

-- Prediction Query
SELECT DISTINCT T3.name FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T2.title = 'Gone with the Wind';

/*
Prediction Result:
('Zachary Rice',)
('Peter Callahan Jr.',)
*/