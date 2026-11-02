-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1089, 'English as a foreign language teacher', 1090, 'reveal');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1092, 'English as a foreign language teacher', 1090, 'reveal');
INSERT INTO "reviewer" ("rid", "name") VALUES (1091, 'Randy Brown');
INSERT INTO "reviewer" ("rid", "name") VALUES (1094, 'Randy Brown');
INSERT INTO "reviewer" ("rid", "name") VALUES (1101, NULL);
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1091, 1089, 4, '1984-04-15');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1101, 1089, 4, '1984-04-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.rid AS rid, LHS.mid AS mid, LHS.stars AS stars, LHS.ratingdate AS ratingdate, RHS.name AS name FROM (SELECT * FROM rating WHERE (stars > 3)) AS LHS LEFT JOIN reviewer AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name;

/*
Gold Result:
(None,)
('Randy Brown',)
*/

-- Prediction Query
SELECT T2.name FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T1.stars > 3;

/*
Prediction Result:
('Randy Brown',)
(None,)
*/