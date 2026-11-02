-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Movie A', 2000, 'Director 1');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'Movie B', 2001, 'Director 2');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (103, 'Movie C', 2002, 'Director 3');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (104, 'Movie D', 2003, 'Director 4');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (105, 'Movie E', 2004, 'Director 5');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Brittany Harris');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, 'Chris Jackson');
INSERT INTO "Reviewer" ("rID", "name") VALUES (203, 'Sarah Martinez');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 105, 5, '2010-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 104, 4, '2010-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (203, 103, 3, '2010-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 102, 2, '2010-01-04');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (203, 101, 1, '2010-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 105, 5, '2010-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "mid" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "rating" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "reviewer" WHERE ("name" = 'Brittany Harris')) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY ratingdate) LIMIT 4);

/*
Gold Result:
(104,)
(103,)
(102,)
(101,)
*/

-- Prediction Query
SELECT mID FROM Rating EXCEPT SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T2.name = 'Brittany Harris';

/*
Prediction Result:
(101,)
(102,)
(103,)
(104,)
*/