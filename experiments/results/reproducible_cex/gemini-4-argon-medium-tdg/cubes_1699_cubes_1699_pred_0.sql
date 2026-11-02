-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Piranha II', 1981, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Star Wars', 1980, 'Irvin Kershner');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Jaws', 1975, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Raiders', 1981, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Xenogenesis', 1978, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Xenogenesis', 1980, 'James Cameron');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Jaws',)
('Piranha II',)
('Star Wars',)
('Xenogenesis',)
('Xenogenesis',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
('Piranha II',)
('Jaws',)
('Xenogenesis',)
('Xenogenesis',)
*/