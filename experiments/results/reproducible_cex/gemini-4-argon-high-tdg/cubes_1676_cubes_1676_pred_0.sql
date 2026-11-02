-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Zorro', 1998, 'Campbell');
INSERT INTO Movie (mID, title, year, director) VALUES (2, 'Matrix', 1999, 'Wachowski');
INSERT INTO Movie (mID, title, year, director) VALUES (3, 'Avatar', 2009, 'Cameron');
INSERT INTO Movie (mID, title, year, director) VALUES (4, 'Titanic', 1997, 'Cameron');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Alice');
INSERT INTO Reviewer (rID, name) VALUES (3, 'Bob');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 2, 5, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 4, 4, '2020-01-02');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (3, 4, 5, '2020-01-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM movie AS LHS WHERE NOT EXISTS(SELECT 1 FROM rating AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title;

/*
Gold Result:
('Avatar',)
('Zorro',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE NOT mID IN (SELECT mID FROM Rating);

/*
Prediction Result:
('Zorro',)
('Avatar',)
*/