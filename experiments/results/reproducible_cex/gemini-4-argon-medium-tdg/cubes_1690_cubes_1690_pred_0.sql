-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Year boundary conditions (1999, 2000, 2001), exact director match vs partial/case-insensitive/NULL, and NULL year.
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Titanic', 1997, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Pre-Millennium', 1999, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Dark Angel Pilot', 2000, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Ghosts of the Abyss', 2001, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (7, 'Memento', 2000, 'Christopher Nolan');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (8, 'Case Test', 2005, 'james cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (9, 'Substring Test', 2005, 'James Cameron Jr.');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (10, 'Null Year Movie', NULL, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (11, 'Null Director Movie', 2005, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' AND YEAR >= 2000) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Avatar',)
('Dark Angel Pilot',)
('Ghosts of the Abyss',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR > 2000;

/*
Prediction Result:
('Ghosts of the Abyss',)
('Avatar',)
*/