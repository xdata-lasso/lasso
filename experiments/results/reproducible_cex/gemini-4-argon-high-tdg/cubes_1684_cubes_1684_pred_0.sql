-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (10, 'Alpha', 2010, 'Dir A');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (20, 'Beta', 2005, 'Dir B');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (30, 'Gamma', 2015, 'Dir C');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (40, 'Delta', 2000, 'Dir D');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (50, 'Epsilon', 2020, 'Dir E');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (60, 'Zeta', 1995, 'Dir F');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'Brittany Harris');
INSERT INTO "Reviewer" ("rID", "name") VALUES (2, 'Alice Smith');
INSERT INTO "Reviewer" ("rID", "name") VALUES (3, 'Bob Jones');
INSERT INTO "Reviewer" ("rID", "name") VALUES (4, 'Charlie Brown');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 20, 3, '2020-01-07');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 10, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (3, 50, 1, '2020-01-06');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (4, 40, 5, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 60, 4, '2020-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 30, 2, '2020-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (3, 10, 4, '2020-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "mid" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "rating" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "reviewer" WHERE ("name" = 'Brittany Harris')) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY ratingdate) LIMIT 4);

/*
Gold Result:
(40,)
(10,)
(30,)
(50,)
*/

-- Prediction Query
SELECT mID FROM Rating EXCEPT SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T2.name = 'Brittany Harris';

/*
Prediction Result:
(20,)
(30,)
(40,)
(50,)
*/