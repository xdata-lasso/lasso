-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1043, 'Accounting technician', 1044, 'song');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1051, 'Pharmacist, hospital', 1052, 'grow');
INSERT INTO "reviewer" ("rid", "name") VALUES (1045, 'Sarah Martinez');
INSERT INTO "reviewer" ("rid", "name") VALUES (1053, 'Sarah Martinez');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1045, 1043, 1046, '1980-11-11');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1045, 1043, 1050, '1981-01-12');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1053, 1051, 1054, '1982-02-13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "director" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM "movie" AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid")) AS "LHS" INNER JOIN (SELECT * FROM "reviewer" WHERE ("name" = 'Sarah Martinez')) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY director, "director" NULLS LAST;

/*
Gold Result:
('grow',)
('song',)
*/

-- Prediction Query
SELECT DISTINCT T2.director FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Sarah Martinez';

/*
Prediction Result:
('song',)
('grow',)
*/