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
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('Civil engineer, consulting', 1050)
('Corporate treasurer', 1043)
('Environmental health practitioner', 1036)
('Financial risk analyst', 1029)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
*/