-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Same Title', 1990, 'Director X');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Same Title', 2020, 'Director Y');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Duplicate Unrated Title', 2000, 'Director Z');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Duplicate Unrated Title', 2005, 'Director W');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, NULL, 2010, 'Director N');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'Chris Jackson');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 1, 5, '2021-05-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM "movie" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."rid" AS "rid", "LHS"."mid" AS "mid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM "rating" AS "LHS" LEFT JOIN "reviewer" AS "RHS" ON ("LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Chris Jackson')) AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('Duplicate Unrated Title',)
('Duplicate Unrated Title',)
('Same Title',)
*/

-- Prediction Query
SELECT DISTINCT title FROM Movie EXCEPT SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Chris Jackson';

/*
Prediction Result:
(None,)
('Duplicate Unrated Title',)
*/