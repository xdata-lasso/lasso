-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Titanic', 1997, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'The Abyss', 1999, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (103, 'Dark Angel', 2000, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (104, 'Solaris', 2001, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (105, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (106, 'Untimely', NULL, 'James Cameron');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' AND YEAR >= 2000) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Avatar',)
('Dark Angel',)
('Solaris',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR > 2000;

/*
Prediction Result:
('Solaris',)
('Avatar',)
*/