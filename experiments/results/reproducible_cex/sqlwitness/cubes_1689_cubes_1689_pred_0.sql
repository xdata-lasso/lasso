-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (mid, title, year, director) VALUES (1, NULL, 1, 'default2'), (0, 'default1', 0, 'default2'), (2, 'default1', 1, 'Steven Spielberg'), (3, 'default2', 1, 'default1'), (4, 'default1', 1, 'default1'), (5, 'default1', NULL, NULL), (6, 'Steven Spielberg', 1, NULL), (7, 'default1', NULL, 'default1'), (8, 'default2', 0, 'Steven Spielberg'), (9, 'default1', NULL, 'Steven Spielberg'), (10, 'default1', 0, 'default1'), (11, 'default2', 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."director" AS "director", "LHS"."year" AS "year", "LHS"."maxyear" AS "maxyear", "RHS"."mid" AS "mid", "RHS"."title" AS "title", "RHS"."year" AS "year_other", "RHS"."director" AS "director_other" FROM (SELECT "director", "year", MAX("year") AS "maxyear" FROM "movie" WHERE ("director" <> 'Steven Spielberg') GROUP BY director, YEAR) AS LHS CROSS JOIN movie AS RHS) WHERE (maxyear <> year_other AND director = director_other) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR > (SELECT MAX(YEAR) FROM Movie WHERE director = 'Steven Spielberg');

/*
Prediction Result:
*/