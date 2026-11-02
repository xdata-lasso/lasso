-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1001, 'Clinical research associate', 1002, 'ago');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1003, 'Clinical research associate', 1002, 'ago');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM "movie" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."rid" AS "rid", "LHS"."mid" AS "mid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM "rating" AS "LHS" LEFT JOIN "reviewer" AS "RHS" ON ("LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Chris Jackson')) AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Clinical research associate',)
('Clinical research associate',)
*/

-- Prediction Query
SELECT DISTINCT title FROM Movie EXCEPT SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Chris Jackson';

/*
Prediction Result:
('Clinical research associate',)
*/