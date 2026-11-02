-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Gone with the Wind', NULL, NULL);
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, NULL, 1999, 'Some Director');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Zack');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, 'Aaron');
INSERT INTO "Reviewer" ("rID", "name") VALUES (203, NULL);
INSERT INTO "Reviewer" ("rID", "name") VALUES (204, NULL);
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 101, NULL, NULL);
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 101, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (203, 101, 3, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (204, 101, 4, '2020-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 102, 5, '2020-01-04');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (NULL, 101, 5, '2020-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, NULL, 5, '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("title" = 'Gone with the Wind') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T3.name FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T2.title = 'Gone with the Wind';

/*
Prediction Result:
('Zack',)
('Aaron',)
(None,)
*/