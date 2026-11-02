-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1001, 'Clinical research associate', 1008, 'require');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1002, 'Agricultural consultant', 1015.0, 'sit');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1003, 'Haematologist', 1022.0, 'wait');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1004, 'Financial risk analyst', 1029.0, 'offer');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1005, 'Environmental health practitioner', 1036.0, 'begin');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1006, 'Corporate treasurer', 1043.0, 'performance');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1007, 'Civil engineer, consulting', 1050.0, 'knowledge');
INSERT INTO "reviewer" ("rid", "name") VALUES (1015, 'Brandon Hall');
INSERT INTO "reviewer" ("rid", "name") VALUES (1016, 'Kristina Baldwin');
INSERT INTO "reviewer" ("rid", "name") VALUES (1017, 'Jennifer Cole');
INSERT INTO "reviewer" ("rid", "name") VALUES (1018, 'Sean Blake');
INSERT INTO "reviewer" ("rid", "name") VALUES (1019, 'Jay Ramirez');
INSERT INTO "reviewer" ("rid", "name") VALUES (1020, 'Phillip Garcia');
INSERT INTO "reviewer" ("rid", "name") VALUES (1021, 'Ian Cooper');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1022, '1970-01-01');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1029.0, '1970-01-02');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1036.0, '1970-01-03');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1043.0, '1970-01-04');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1050.0, '1970-01-05');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1057.0, '1970-01-06');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1015, 1001, 1064.0, '1970-01-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "mid" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "rating" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "reviewer" WHERE ("name" = 'Brittany Harris')) AS RHS WHERE (LHS.rid = RHS.rid))) ORDER BY ratingdate) LIMIT 4);

/*
Gold Result:
(1001,)
(1001,)
(1001,)
(1001,)
*/

-- Prediction Query
SELECT mID FROM Rating EXCEPT SELECT T1.mID FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID WHERE T2.name = 'Brittany Harris';

/*
Prediction Result:
(1001,)
*/