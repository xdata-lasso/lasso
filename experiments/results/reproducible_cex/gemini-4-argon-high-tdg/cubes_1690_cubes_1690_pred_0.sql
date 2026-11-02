-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Ghosts of the Abyss', 2003, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Dark Angel', 2000, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Titanic', 1999, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'True Lies', 1994, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Memento', 2000, 'Christopher Nolan');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (7, 'Inception', 2010, 'Christopher Nolan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' AND YEAR >= 2000) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Avatar',)
('Dark Angel',)
('Ghosts of the Abyss',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR > 2000;

/*
Prediction Result:
('Ghosts of the Abyss',)
('Avatar',)
*/