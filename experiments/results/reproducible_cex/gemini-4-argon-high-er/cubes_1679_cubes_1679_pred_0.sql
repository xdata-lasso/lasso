-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Inception', 2010, 'Christopher Nolan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('Inception', 2010)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
*/