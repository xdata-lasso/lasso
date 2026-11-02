-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, 't2__9e3a7f', -55602865, 'swwqcgsk');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (2, 't2__9e3a7f', 1744686505, 'hria2ypu');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483647, 't2__9e3a7f', 1644814318, 'sr');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (3, 'p6luhvdlttil', 429706943, 'rmdp');

-- Inserting into table: reviewer --
INSERT INTO "reviewer" ("rid", "name") VALUES (-2147483648, '9n8c4pgu7v');

-- Inserting into table: rating --
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 3, '2020-12-20');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 2, 3, '2020-05-06');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 3, 4, '2022-07-21');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 2, 3, '2021-06-28');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 2, 3, '2020-11-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 2, 3, '2023-09-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 3, '2023-11-17');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 4, '2021-12-14');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 3, '2020-01-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 4, '2024-09-12');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 3, '2023-05-08');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 4, '2020-06-05');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 6, '2020-11-01');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483648, 1, 3, '2021-06-11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars >= 3 OR stars >= 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY title;

/*
Gold Result:
('p6luhvdlttil',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
*/

-- Prediction Query
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID WHERE T1.stars BETWEEN 3 AND 5;

/*
Prediction Result:
('t2__9e3a7f',)
('t2__9e3a7f',)
('p6luhvdlttil',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
('t2__9e3a7f',)
*/