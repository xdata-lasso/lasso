-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1001, 'Clinical research associate', 1004, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1002, 'Agricultural consultant', 1011.0, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1003, 'Haematologist', 1018.0, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1007, 'Environmental health practitioner', 1010, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1008, 'Corporate treasurer', 1010, 'election');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1009, 'Civil engineer, consulting', 1010, 'election');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."director" AS "director", "LHS"."year" AS "year", "LHS"."maxyear" AS "maxyear", "RHS"."mid" AS "mid", "RHS"."title" AS "title", "RHS"."year" AS "year_other", "RHS"."director" AS "director_other" FROM (SELECT "director", "year", MAX("year") AS "maxyear" FROM "movie" WHERE ("director" <> 'Steven Spielberg') GROUP BY director, YEAR) AS LHS CROSS JOIN movie AS RHS) WHERE (maxyear <> year_other AND director = director_other) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Agricultural consultant',)
('Agricultural consultant',)
('Agricultural consultant',)
('Civil engineer, consulting',)
('Civil engineer, consulting',)
('Civil engineer, consulting',)
('Clinical research associate',)
('Clinical research associate',)
('Clinical research associate',)
('Corporate treasurer',)
('Corporate treasurer',)
('Corporate treasurer',)
('Environmental health practitioner',)
('Environmental health practitioner',)
('Environmental health practitioner',)
('Haematologist',)
('Haematologist',)
('Haematologist',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR > (SELECT MAX(YEAR) FROM Movie WHERE director = 'Steven Spielberg');

/*
Prediction Result:
*/