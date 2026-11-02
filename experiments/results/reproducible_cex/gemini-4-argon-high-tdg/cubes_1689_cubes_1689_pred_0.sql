-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Titanic', 1997, 'James Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'The Terminator', 1984, 'James Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Jaws', 1975, 'Steven Spielberg');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Sarah Martinez');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 5, '2020-01-10');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 4, '2020-01-15');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 3, 5, '2020-02-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."director" AS "director", "LHS"."year" AS "year", "LHS"."maxyear" AS "maxyear", "RHS"."mid" AS "mid", "RHS"."title" AS "title", "RHS"."year" AS "year_other", "RHS"."director" AS "director_other" FROM (SELECT "director", "year", MAX("year") AS "maxyear" FROM "movie" WHERE ("director" <> 'Steven Spielberg') GROUP BY director, YEAR) AS LHS CROSS JOIN movie AS RHS) WHERE (maxyear <> year_other AND director = director_other) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('The Terminator',)
('Titanic',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR > (SELECT MAX(YEAR) FROM Movie WHERE director = 'Steven Spielberg');

/*
Prediction Result:
('Titanic',)
('The Terminator',)
('Inception',)
*/