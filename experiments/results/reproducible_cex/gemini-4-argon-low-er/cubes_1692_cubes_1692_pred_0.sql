-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Z', 2000, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'A', 2000, 'Steven Spielberg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'Steven Spielberg') ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('A',)
('Z',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'Steven Spielberg';

/*
Prediction Result:
('Z',)
('A',)
*/