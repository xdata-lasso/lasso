-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'B', 2000, 'Dir1');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'A', 2001, 'Dir2');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'Rev1');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, NULL, 5, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM movie AS LHS WHERE NOT EXISTS(SELECT 1 FROM rating AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE NOT mID IN (SELECT mID FROM Rating);

/*
Prediction Result:
*/