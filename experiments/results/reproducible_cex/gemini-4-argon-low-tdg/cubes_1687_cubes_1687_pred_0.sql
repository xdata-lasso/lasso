-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Gone with the Wind', 1939, 'Victor Fleming');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'The Wizard of Oz', 1939, 'Victor Fleming');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (103, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (104, 'Star Wars', 1977, 'George Lucas');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (105, 'Unknown Project', 2020, NULL);
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Sarah Martinez');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, 'Daniel Lewis');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 101, 4, '2021-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 101, 5, '2021-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 102, 3, '2021-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 103, 5, '2021-01-04');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 105, 2, '2021-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 104, 4, '2021-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "director" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM "movie" AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid")) AS "LHS" INNER JOIN (SELECT * FROM "reviewer" WHERE ("name" = 'Sarah Martinez')) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY director, "director" NULLS LAST;

/*
Gold Result:
(None,)
('James Cameron',)
('Victor Fleming',)
*/

-- Prediction Query
SELECT DISTINCT T2.director FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Sarah Martinez';

/*
Prediction Result:
('Victor Fleming',)
('James Cameron',)
(None,)
*/