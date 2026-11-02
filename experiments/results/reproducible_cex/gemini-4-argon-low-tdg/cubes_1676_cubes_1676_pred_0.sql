-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ordering of results, and preservation of duplicate titles for unrated movies (kills SELECT DISTINCT and missing/DESC ORDER BY)
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Zebra', 2000, 'Dir A');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Apple', 2001, 'Dir B');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Apple', 2002, 'Dir C');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Mango', 2003, 'Dir D');
INSERT INTO "Reviewer" ("rID", "name") VALUES (10, 'Rev 1');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (10, 4, 5, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM movie AS LHS WHERE NOT EXISTS(SELECT 1 FROM rating AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title;

/*
Gold Result:
('Apple',)
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE NOT mID IN (SELECT mID FROM Rating);

/*
Prediction Result:
('Zebra',)
('Apple',)
('Apple',)
*/