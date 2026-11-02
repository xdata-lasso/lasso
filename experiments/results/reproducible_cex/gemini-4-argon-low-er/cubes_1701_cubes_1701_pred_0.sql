-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'A', 2000, 'null');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.director AS director_other, RHS.n AS n FROM movie AS LHS CROSS JOIN (SELECT * FROM (SELECT director, COUNT(*) AS n FROM movie GROUP BY director) WHERE (n <= 1)) AS RHS) WHERE (director = director_other) ORDER BY director;

/*
Gold Result:
('null',)
*/

-- Prediction Query
SELECT director FROM Movie WHERE director <> 'null' GROUP BY director HAVING COUNT(*) = 1;

/*
Prediction Result:
*/