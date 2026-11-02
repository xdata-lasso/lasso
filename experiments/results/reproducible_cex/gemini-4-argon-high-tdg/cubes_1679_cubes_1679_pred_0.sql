-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Blade Runner', 1982, 'Ridley Scott');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Inception', 2010, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Se7en', 1995, 'David Fincher');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Tenet', 2020, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Batman Begins', 2005, 'Christopher Nolan');
INSERT INTO Movie (mID, title, year, director) VALUES (6, 'Memento', 2000, 'Christopher Nolan');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (102, 'Bob');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 2, 5, '2021-01-10');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 2, 4, '2021-01-12');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 5, '2021-02-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 1, 5, '2021-02-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 3, 4, '2021-03-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('Tenet', 2020)
('Inception', 2010)
('Batman Begins', 2005)
('Memento', 2000)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
('Inception', 2010)
('Inception', 2010)
('Inception', 2010)
('Tenet', 2020)
('Tenet', 2020)
('Tenet', 2020)
('Batman Begins', 2005)
('Batman Begins', 2005)
('Batman Begins', 2005)
('Memento', 2000)
('Memento', 2000)
('Memento', 2000)
*/