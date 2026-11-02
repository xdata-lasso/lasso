-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1039, 'Dramatherapist', 1040, 'none');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1040, 'Surveyor, hydrographic', 1043, 'discuss');
INSERT INTO "reviewer" ("rid", "name") VALUES (1042, 'Carla Gray');
INSERT INTO "reviewer" ("rid", "name") VALUES (1041, 'Sarah Parsons');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1042, 1039, 5, '1983-03-14');
INSERT INTO "rating" ("rid", "mid", "stars", "ratingdate") VALUES (1041, 1040, 5, '1983-03-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rid FROM rating WHERE (stars <> 4) ORDER BY rid, rating.mid NULLS LAST, rating.stars NULLS LAST, rating.ratingdate NULLS LAST;

/*
Gold Result:
(1041,)
(1042,)
*/

-- Prediction Query
SELECT rID FROM Rating WHERE stars <> 4;

/*
Prediction Result:
(1042,)
(1041,)
*/