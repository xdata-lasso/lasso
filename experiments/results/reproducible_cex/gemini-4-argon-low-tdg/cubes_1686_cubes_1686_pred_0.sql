-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Zorro', 1998, 'Martin Campbell');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Avatar', 2009, 'James Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Batman', 1989, 'Tim Burton');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Dune', 2021, 'Denis Villeneuve');
INSERT INTO Movie (mID, title, year, director) VALUES (5, 'Cats', 2019, 'Tom Hooper');
INSERT INTO Movie (mID, title, year, director) VALUES (6, 'Matrix', 1999, 'Wachowskis');
INSERT INTO Reviewer (rID, name) VALUES (101, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (102, 'Bob');
INSERT INTO Reviewer (rID, name) VALUES (103, 'Charlie');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 1, 3, '2023-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (101, 2, 4, '2023-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 3, 5, '2023-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (102, 4, 2, '2023-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (103, 5, 1, '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars >= 3 OR stars >= 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY title;

/*
Gold Result:
('Avatar',)
('Batman',)
('Zorro',)
*/

-- Prediction Query
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID WHERE T1.stars BETWEEN 3 AND 5;

/*
Prediction Result:
('Zorro',)
('Avatar',)
('Batman',)
*/