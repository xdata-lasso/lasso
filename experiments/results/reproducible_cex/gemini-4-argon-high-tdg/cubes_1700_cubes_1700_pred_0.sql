-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (103, 'Inception', 2020, 'Unknown');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (104, 'Dune', 1984, 'David Lynch');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (105, 'Dune', 2021, 'Denis Villeneuve');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'Chris Jackson');
INSERT INTO "Reviewer" ("rID", "name") VALUES (2, 'Sarah Martinez');
INSERT INTO "Reviewer" ("rID", "name") VALUES (3, 'Brittany Harris');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 101, 5, '2022-03-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (3, 101, 4, '2022-03-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 104, 2, '2022-03-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 105, 5, '2022-03-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM "movie" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "LHS"."rid" AS "rid", "LHS"."mid" AS "mid", "LHS"."stars" AS "stars", "LHS"."ratingdate" AS "ratingdate", "RHS"."name" AS "name" FROM "rating" AS "LHS" LEFT JOIN "reviewer" AS "RHS" ON ("LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Chris Jackson')) AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Avatar',)
('Dune',)
('Inception',)
('Inception',)
*/

-- Prediction Query
SELECT DISTINCT title FROM Movie EXCEPT SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Chris Jackson';

/*
Prediction Result:
('Avatar',)
('Inception',)
*/