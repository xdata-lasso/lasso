-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'M1', 2000, 'D1');
INSERT INTO Reviewer (rID, name) VALUES (1, 'B');
INSERT INTO Reviewer (rID, name) VALUES (2, 'A');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 4, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (2, 1, 4, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (NULL, 1, 4, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.mid AS mid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.name AS name FROM (SELECT * FROM rating WHERE (stars > 3)) AS LHS LEFT JOIN reviewer AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
(None,)
('A',)
('B',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T1.stars > 3;

/*
Prediction Result:
('B',)
('A',)
*/