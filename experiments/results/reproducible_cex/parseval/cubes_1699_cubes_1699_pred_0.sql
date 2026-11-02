-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: movie --
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1, 'mov_e39323', -5853, NULL);

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (3, 'mov_e39323', -5853, NULL);

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (2, '5k5swwqcgs', 247012447, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (4, '8c4pgu7vfe', 1980, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (5, 'hria2ypu', NULL, 'James Cameron');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (6, 'hsrwbbp', 1980, 'mov_08ae56');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (7, 'luhvdltti', 1981, 'mov_08ae56');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (8, 'bnp', NULL, 'mov_08ae56');

INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (9, 'mdpos', 1981, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('5k5swwqcgs',)
('8c4pgu7vfe',)
('hria2ypu',)
('hsrwbbp',)
('mov_e39323',)
('mov_e39323',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
('mov_e39323',)
('5k5swwqcgs',)
('mov_e39323',)
('8c4pgu7vfe',)
('hria2ypu',)
*/