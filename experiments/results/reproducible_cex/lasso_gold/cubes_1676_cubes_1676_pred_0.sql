-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1019, 'Sports administrator', 1020, 'option');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1021, 'Aid worker', 1021, 'sense');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM movie AS LHS WHERE NOT EXISTS(SELECT 1 FROM rating AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title;

/*
Gold Result:
('Aid worker',)
('Sports administrator',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE NOT mID IN (SELECT mID FROM Rating);

/*
Prediction Result:
('Sports administrator',)
('Aid worker',)
*/