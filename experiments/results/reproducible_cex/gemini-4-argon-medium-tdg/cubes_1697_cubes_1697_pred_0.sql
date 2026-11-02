-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests star rating boundary values (4, 5, 6, NULL), INNER JOIN vs OUTER JOIN (unrated movies), and multi-column sorting.
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'B_Title', 2000, 'Z_Director');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'A_Title', 2001, 'Z_Director');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (103, 'C_Title', 2002, 'A_Director');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (104, 'Unrated_Movie', 2003, 'B_Director');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (105, 'Four_Star_Movie', 2004, 'C_Director');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (106, 'Six_Star_Movie', 2005, 'D_Director');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (107, 'Null_Star_Movie', 2006, 'E_Director');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Reviewer_One');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 101, 5, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 102, 5, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 103, 5, '2020-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 105, 4, '2020-01-04');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 106, 6, '2020-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 107, NULL, '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director, title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars = 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY director, title NULLS LAST;

/*
Gold Result:
('A_Director', 'C_Title')
('Z_Director', 'A_Title')
('Z_Director', 'B_Title')
*/

-- Prediction Query
SELECT T1.director, T1.title FROM Movie AS T1 JOIN Rating AS T2 ON T1.mID = T2.mID WHERE T2.stars = 5;

/*
Prediction Result:
('Z_Director', 'B_Title')
('Z_Director', 'A_Title')
('A_Director', 'C_Title')
*/