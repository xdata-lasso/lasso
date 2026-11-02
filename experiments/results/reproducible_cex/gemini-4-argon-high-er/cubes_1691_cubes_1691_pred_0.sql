-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'Movie A', 2020, 'Director A');
INSERT INTO Reviewer (rID, name) VALUES (1, 'Reviewer A');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 1, '2020-01-01');
INSERT INTO Rating (rID, mID, stars, ratingDate) VALUES (1, 1, 1, '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT mid, meanstars AS avg_stars_ FROM (SELECT mid, meanstars, COUNT(*) OVER () AS n FROM (SELECT mid, AVG(stars) AS meanstars FROM rating GROUP BY mid)) WHERE (meanstars >= 2.0 AND meanstars <= n) ORDER BY mid, avg_stars_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT mID, AVG(stars) FROM Rating GROUP BY mID HAVING COUNT(*) >= 2;

/*
Prediction Result:
(1, 1.0)
*/