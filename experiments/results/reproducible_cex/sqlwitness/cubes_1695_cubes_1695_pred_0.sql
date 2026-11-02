-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (mid, title, year, director) VALUES (1, 'default2', 0, 'default1'), (0, 'default2', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.mid AS mid_other, RHS.director AS director_other FROM (SELECT mid, title, MAX(YEAR) OVER () AS YEAR, director FROM movie) AS LHS INNER JOIN movie AS RHS ON (LHS.title = RHS.title AND LHS.year = RHS.year)) ORDER BY title;

/*
Gold Result:
('default2',)
('default2',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR = (SELECT MAX(YEAR) FROM Movie);

/*
Prediction Result:
('default2',)
*/