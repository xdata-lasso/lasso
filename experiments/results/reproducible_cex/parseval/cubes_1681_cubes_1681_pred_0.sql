-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

-- Inserting into table: reviewer --
INSERT INTO "reviewer" ("rid", "name") VALUES (1, 't2__4f4ec3');

INSERT INTO "reviewer" ("rid", "name") VALUES (2, 't2__4f4ec3');

INSERT INTO "reviewer" ("rid", "name") VALUES (-2147483647, 't2__4f4ec3');

INSERT INTO "reviewer" ("rid", "name") VALUES (3, 'uzhs');

INSERT INTO "reviewer" ("rid", "name") VALUES (5, 'p');

-- Inserting into table: rating --
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1633151678, '2021-07-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (2, -2147483648, 1268590800, '2024-03-30');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (3, -2147483648, 906324270, '2020-05-06');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (5, -2147483648, -1659388584, '2020-08-14');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (5, -2147483648, -845863578, '2021-05-27');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (5, -2147483648, 429706943, '2022-09-14');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 2087640001, '2020-07-11');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 2026480202, '2021-06-28');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1823627488, '2023-09-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 44952191, '2021-12-14');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 1038707349, '2024-07-24');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 947159877, '2023-05-08');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2020-06-05');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2020-11-01');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2021-06-11');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2020-07-02');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2025-03-28');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2021-06-20');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2022-02-24');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, NULL, '2025-01-28');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('p', -691848406.3333334)
('t2__4f4ec3', 384022922.0)
('t2__4f4ec3', 1268590800.0)
('uzhs', 906324270.0)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('p', -691848406.3333334)
('t2__4f4ec3', 494593906.75)
('uzhs', 906324270.0)
*/