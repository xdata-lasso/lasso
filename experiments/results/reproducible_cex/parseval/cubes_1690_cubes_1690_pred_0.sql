-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, 'mov_09e131', 2000, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483647, 'mov_09e131', 2000, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (2, '5k5swwqcgs', 1999, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (3, '9n8', NULL, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (4, '4', 2000, 'mov_a31588');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (5, 'gu7v', 1999, 'mov_a31588');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (6, 'e4', NULL, 'mov_a31588');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (7, 'hria2ypuzhs', 2000, NULL);

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (8, 'rwbbp6luhvd', 1999, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' AND YEAR >= 2000) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('mov_09e131',)
('mov_09e131',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR > 2000;

/*
Prediction Result:
*/