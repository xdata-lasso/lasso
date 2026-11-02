-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (exact match vs other director vs NULL vs case sensitivity) and basic ordering
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Jaws', 1975, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'E.T.', 1982, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Unknown', 2000, NULL);
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Hook', 1991, 'steven spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Lincoln', 2012, 'Steven Spielberg ');
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