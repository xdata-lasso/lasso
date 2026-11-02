-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (105, 'Movie A', 1995, 'Director 1');
INSERT INTO Movie (mID, title, year, director) VALUES (102, 'Movie B', 2010, 'Director 2');
INSERT INTO Movie (mID, title, year, director) VALUES (104, 'Movie C', 2005, 'Director 3');
INSERT INTO Movie (mID, title, year, director) VALUES (101, 'Movie D', 2020, 'Director 4');
INSERT INTO Movie (mID, title, year, director) VALUES (106, 'Movie E', 1980, 'Director 5');
INSERT INTO Movie (mID, title, year, director) VALUES (103, 'Movie F', 2000, 'Director 6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('Movie D', 2020)
('Movie B', 2010)
('Movie C', 2005)
('Movie F', 2000)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
*/