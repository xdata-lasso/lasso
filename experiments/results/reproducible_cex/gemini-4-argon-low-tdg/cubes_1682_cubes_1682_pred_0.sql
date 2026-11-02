-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (101, 'Movie A', 2000, 'Director A');
INSERT INTO "Reviewer" ("rID", "name") VALUES (201, 'Reviewer 1');
INSERT INTO "Reviewer" ("rID", "name") VALUES (202, 'Reviewer 2');
INSERT INTO "Reviewer" ("rID", "name") VALUES (203, 'Reviewer 3');
INSERT INTO "Reviewer" ("rID", "name") VALUES (204, 'Reviewer 4');
INSERT INTO "Reviewer" ("rID", "name") VALUES (205, 'Reviewer 5');
INSERT INTO "Reviewer" ("rID", "name") VALUES (206, 'Reviewer 6');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (205, 101, 1, '2020-01-01');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (204, 101, 2, '2020-01-02');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (203, 101, 3, '2020-01-03');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (202, 101, 4, '2020-01-04');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (201, 101, 5, '2020-01-05');
INSERT INTO "Rating" ("rID", "mID", "stars", "ratingDate") VALUES (206, 101, NULL, '2020-01-06');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rid FROM rating WHERE (stars <> 4) ORDER BY rid, rating.mid NULLS LAST, rating.stars NULLS LAST, rating.ratingdate NULLS LAST;

/*
Gold Result:
(201,)
(203,)
(204,)
(205,)
*/

-- Prediction Query
SELECT rID FROM Rating WHERE stars <> 4;

/*
Prediction Result:
(205,)
(204,)
(203,)
(201,)
*/