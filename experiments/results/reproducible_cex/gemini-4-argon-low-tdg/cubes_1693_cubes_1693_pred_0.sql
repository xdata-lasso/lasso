-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Inception', 2010, 'Nolan');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'Avatar', 2009, 'Cameron');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'Charlie');
INSERT INTO "Reviewer" ("rID", "name") VALUES (2, 'Alice');
INSERT INTO "Reviewer" ("rID", "name") VALUES (3, 'Bob');
INSERT INTO "Reviewer" ("rID", "name") VALUES (4, 'David');
INSERT INTO "Reviewer" ("rID", "name") VALUES (5, 'Eve');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 101, 4, '2023-01-10');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 101, 5, '2023-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 102, 4, '2023-01-15');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (3, 101, 3, '2023-01-12');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (4, 102, 2, '2023-01-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.mid AS mid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.name AS name FROM (SELECT * FROM rating WHERE (stars > 3)) AS LHS LEFT JOIN reviewer AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T1.stars > 3;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Alice',)
*/