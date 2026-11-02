-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, 'mov_0d459a', 1, 'mov_e6b54e');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483647, 'mov_40908d', 1, 'mov_2350d0');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483646, 'q_1_7c9f33', 1, '5k5swwqcgs');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483645, 'q_1_7c9f33', 1, '9n8');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483644, 'q_1_7c9f33', 1, '4');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-2147483643, 'q_1_7c9f33', 1, 'gu7v');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (-1, 'e4', 7719, 'hria2ypuzhs');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (0, 'rwbbp6luhvd', 0, 'tti');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (2, 'bnp', -21238, 'mdpos');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (3, 'ie5', -2437, 'nw6klf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('e4', 7719)
('mov_40908d', 1)
('q_1_7c9f33', 1)
('q_1_7c9f33', 1)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
*/