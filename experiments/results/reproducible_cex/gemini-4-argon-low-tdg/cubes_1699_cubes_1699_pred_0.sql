-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests OR vs AND, boundary conditions on year (1979, 1980, 1981), and director matching (exact, case-sensitivity, substring)
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Star Wars', 1977, 'George Lucas');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'The Empire Strikes Back', 1980, 'Irvin Kershner');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Xenogenesis', 1978, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Piranha II', 1981, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (7, 'Fake Cameron', 2000, 'james cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (8, 'Sub Cameron', 2000, 'James Cameron Jr.');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Avatar',)
('Piranha II',)
('Star Wars',)
('The Empire Strikes Back',)
('Xenogenesis',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
('Avatar',)
('Star Wars',)
('Xenogenesis',)
('Piranha II',)
*/