-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, '9n8', 1610062532, 'pgu7vfe4');

-- Inserting into table: reviewer --
INSERT INTO "reviewer" ("rid", "name") VALUES (1, '5k5swwqcgs');

-- Inserting into table: rating --
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, NULL, '2024-06-15');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1, '2024-06-15');

INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1, 1, 1, '2024-06-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "mid" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "rating" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "reviewer" WHERE ("name" = 'Brittany Harris')) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY ratingdate) LIMIT 4);

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT mID FROM Rating EXCEPT SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T2.name = 'Brittany Harris';

/*
Prediction Result:
(1,)
*/