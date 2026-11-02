-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (2, 'mov_cc735a', -55602865, 'swwqcgsk');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (3, 'mov_cc735a', 1610062532, 'pgu7vfe4');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483646, 'mov_cc735a', 1160656988, 'ia2yp');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483645, 'uzhsrwbbp6lu', NULL, 'hvdlttilbnpr');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483644, 'dpos', NULL, 'ie5');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483643, NULL, -1209887326, 'klfa9000t');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483642, NULL, 1408123494, '4');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483641, NULL, NULL, 'ecigce376n');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483640, NULL, NULL, 'um5');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483639, 'mov_cc735a', 742285925, 'u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.mid AS mid_other, RHS.director AS director_other FROM (SELECT mid, title, MAX(YEAR) OVER () AS YEAR, director FROM movie) AS LHS INNER JOIN movie AS RHS ON (LHS.title = RHS.title AND LHS.year = RHS.year)) ORDER BY title;

/*
Gold Result:
('mov_cc735a',)
('mov_cc735a',)
('mov_cc735a',)
('mov_cc735a',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE YEAR = (SELECT MAX(YEAR) FROM Movie);

/*
Prediction Result:
('mov_cc735a',)
*/