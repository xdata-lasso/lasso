-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Movie A', 2000, 'Director Z');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Movie B', 2001, 'Director Z');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Movie C', 2002, 'Director A');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Movie D', 2003, NULL);
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Movie E', 2004, 'Director M');
INSERT INTO "Reviewer" ("rID", "name") VALUES (10, 'Sarah Martinez');
INSERT INTO "Reviewer" ("rID", "name") VALUES (11, 'Sarah Martinez');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 1, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 1, 4, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 2, 3, '2020-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (11, 3, 5, '2020-01-04');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 4, 2, '2020-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (11, 5, 1, '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "director" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM "movie" AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid")) AS "LHS" INNER JOIN (SELECT * FROM "reviewer" WHERE ("name" = 'Sarah Martinez')) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY director, "director" NULLS LAST;

/*
Gold Result:
(None,)
('Director A',)
('Director M',)
('Director Z',)
*/

-- Prediction Query
SELECT DISTINCT T2.director FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Sarah Martinez';

/*
Prediction Result:
('Director Z',)
('Director A',)
(None,)
('Director M',)
*/