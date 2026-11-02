-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Solaris', 1972, 'Andrei Tarkovsky');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Stalker', 1979, 'Andrei Tarkovsky');
INSERT INTO Reviewer (rID, name) VALUES (10, 'Alex');
INSERT INTO Reviewer (rID, name) VALUES (20, 'Alex');
INSERT INTO Reviewer (rID, name) VALUES (30, 'Alex');
INSERT INTO Reviewer (rID, name) VALUES (40, 'Beth');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (10, 1, NULL, '2023-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 1, 5, '2023-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (20, 2, 4, '2023-01-03');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (30, 1, 2, '2023-01-04');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (40, 2, 1, '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('Alex', 2.0)
('Alex', 4.5)
('Alex', None)
('Beth', 1.0)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('Alex', 3.6666666666666665)
('Beth', 1.0)
*/