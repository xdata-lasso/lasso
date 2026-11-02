-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483648, '5k5swwqcgs', 247012447, '8c4pgu7vfe');

-- Inserting into table: reviewer --
INSERT INTO "reviewer" ("rid", "name") VALUES (1, 'lhs_009026');

INSERT INTO "reviewer" ("rid", "name") VALUES (-2147483647, 'lhs_8d6281');

-- Inserting into table: rating --
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1633151678, '2021-07-04');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 1268590800, '2024-03-30');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1670923962, '2023-01-03');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 1908028688, '2020-03-30');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 13244799, '2023-08-07');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1910425938, '2023-05-26');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (-2147483647, -2147483648, -1364429300, '2022-04-29');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 2087640001, '2020-07-11');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -918961358, '2021-06-03');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -45536098, '2022-06-13');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1399556171, '2020-01-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 546571701, '2024-09-18');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 1408123494, '2020-06-05');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 374105386, '2020-06-23');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 1149850321, '2020-07-02');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1585009206, '2022-02-24');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 742285925, '2020-03-30');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -1179823637, '2022-04-13');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -967741825, '2020-12-02');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, -472966518, '2025-06-25');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, -2147483648, 902551284, '2020-04-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.n AS n FROM reviewer AS LHS INNER JOIN (SELECT * FROM (SELECT rid, COUNT(*) AS n FROM rating GROUP BY rid) WHERE (n = 3)) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T1.rID HAVING COUNT(*) >= 3;

/*
Prediction Result:
('lhs_009026',)
*/