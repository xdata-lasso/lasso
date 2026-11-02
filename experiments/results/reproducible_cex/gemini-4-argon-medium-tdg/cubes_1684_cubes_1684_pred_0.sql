-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Gone with the Wind', 1939, 'Victor Fleming');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (102, 'Star Wars', 1977, 'George Lucas');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (103, 'The Sound of Music', 1965, 'Robert Wise');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (104, 'E.T.', 1982, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (105, 'Titanic', 1997, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (106, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Brittany Harris');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, 'Sarah Martinez');
INSERT INTO "Reviewer" ("rID", "name") VALUES (203, 'Daniel Lewis');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 101, 5, '2011-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 102, 4, '2011-01-10');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (203, 103, 3, '2011-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 104, 2, '2011-01-15');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (203, 105, 1, '2011-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 106, 5, '2011-01-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "mid" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "rating" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "reviewer" WHERE ("name" = 'Brittany Harris')) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY ratingdate) LIMIT 4);

/*
Gold Result:
(105,)
(103,)
(102,)
(104,)
*/

-- Prediction Query
SELECT mID FROM Rating EXCEPT SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T2.name = 'Brittany Harris';

/*
Prediction Result:
(102,)
(103,)
(104,)
(105,)
(106,)
*/