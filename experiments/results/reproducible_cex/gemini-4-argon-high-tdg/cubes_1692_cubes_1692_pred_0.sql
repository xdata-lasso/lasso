-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (10, 'Jaws', 1975, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (20, 'E.T.', 1982, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (30, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (40, 'Steven Spielberg', 2000, 'George Lucas');
INSERT INTO "Reviewer" ("rID", "name") VALUES (1, 'Alice');
INSERT INTO "Reviewer" ("rID", "name") VALUES (2, 'Bob');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 10, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (2, 10, 4, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (1, 30, 5, '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'Steven Spielberg') ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('E.T.',)
('Jaws',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'Steven Spielberg';

/*
Prediction Result:
('Jaws',)
('E.T.',)
*/