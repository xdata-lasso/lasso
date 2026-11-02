-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Avatar', 2000, 'Zack Snyder');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Avatar', 2022, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Titanic', 1997, 'James Cameron');
INSERT INTO "Reviewer" ("rID", "name") VALUES (101, 'Alice');
INSERT INTO "Reviewer" ("rID", "name") VALUES (102, 'Bob');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 2, 5, '2010-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (102, 2, 4, '2010-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (101, 4, 5, '2010-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "director" FROM "movie" WHERE ("title" = 'Avatar') ORDER BY director, movie.mid NULLS LAST;

/*
Gold Result:
('James Cameron',)
('James Cameron',)
('Zack Snyder',)
*/

-- Prediction Query
SELECT director FROM Movie WHERE title = 'Avatar';

/*
Prediction Result:
('Zack Snyder',)
('James Cameron',)
('James Cameron',)
*/