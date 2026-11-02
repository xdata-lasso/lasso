-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'A', 2000, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'B', 2005, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'C', 1990, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'D', 1990, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'E', 1995, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'F', 2000, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (7, 'G', 2010, 'Quentin Tarantino');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (8, 'H', 2010, 'Quentin Tarantino');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."director" AS "director", "LHS"."year" AS "year", "LHS"."maxyear" AS "maxyear", "RHS"."mid" AS "mid", "RHS"."title" AS "title", "RHS"."year" AS "year_other", "RHS"."director" AS "director_other" FROM (SELECT "director", "year", MAX("year") AS "maxyear" FROM "movie" WHERE ("director" <> 'Steven Spielberg') GROUP BY director, YEAR) AS LHS CROSS JOIN movie AS RHS) WHERE (maxyear <> year_other AND director = director_other) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('C',)
('C',)
('D',)
('D',)
('E',)
('E',)
('F',)
('F',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR > (SELECT MAX(YEAR) FROM Movie WHERE director = 'Steven Spielberg');

/*
Prediction Result:
('G',)
('H',)
*/