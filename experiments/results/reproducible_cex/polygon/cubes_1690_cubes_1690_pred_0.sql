-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (8, 'James Cameron10', 2000, 'James Cameron');
INSERT INTO "Movie" ("mid", "title", "year", "director") VALUES (7, 'James Cameron7', -635, 'James Cameron7');
INSERT INTO "Reviewer" ("rid", "name") VALUES (9, 'James Cameron7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' AND YEAR >= 2000) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('James Cameron10',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR > 2000;

/*
Prediction Result:
*/