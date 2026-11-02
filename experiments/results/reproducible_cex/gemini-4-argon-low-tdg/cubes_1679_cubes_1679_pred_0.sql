-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (105, 'Movie E', 2020, 'Director 1');
INSERT INTO Movie (mID, title, year, director) VALUES (101, 'Movie A', 2020, 'Director 2');
INSERT INTO Movie (mID, title, year, director) VALUES (103, 'Movie C', 2022, 'Director 1');
INSERT INTO Movie (mID, title, year, director) VALUES (102, 'Movie B', 2021, 'Director 3');
INSERT INTO Movie (mID, title, year, director) VALUES (104, 'Movie D', 2019, 'Director 2');
INSERT INTO Movie (mID, title, year, director) VALUES (106, 'Movie F', 2018, 'Director 4');
INSERT INTO Reviewer (rID, name) VALUES (201, 'Reviewer 1');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (201, 101, 5, '2023-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (201, 101, 4, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('Movie C', 2022)
('Movie B', 2021)
('Movie A', 2020)
('Movie E', 2020)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
('Movie A', 2020)
('Movie C', 2022)
('Movie D', 2019)
('Movie E', 2020)
*/