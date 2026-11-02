-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Jaws', 1975, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Avatar', 2009, 'James Cameron');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."director" AS "director", "LHS"."year" AS "year", "LHS"."maxyear" AS "maxyear", "RHS"."mid" AS "mid", "RHS"."title" AS "title", "RHS"."year" AS "year_other", "RHS"."director" AS "director_other" FROM (SELECT "director", "year", MAX("year") AS "maxyear" FROM "movie" WHERE ("director" <> 'Steven Spielberg') GROUP BY director, YEAR) AS LHS CROSS JOIN movie AS RHS) WHERE (maxyear <> year_other AND director = director_other) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR > (SELECT MAX(YEAR) FROM Movie WHERE director = 'Steven Spielberg');

/*
Prediction Result:
('Avatar',)
*/