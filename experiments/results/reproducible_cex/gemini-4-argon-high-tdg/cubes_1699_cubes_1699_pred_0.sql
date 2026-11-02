-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Terminator', 1984, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Piranha II', 1980, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Xenogenesis', 1978, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'The Shining', 1980, 'Stanley Kubrick');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Alien', 1979, 'Ridley Scott');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (7, 'Blade Runner', 1982, 'Ridley Scott');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Alien',)
('Piranha II',)
('Terminator',)
('The Shining',)
('Xenogenesis',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
('Terminator',)
('Piranha II',)
('Xenogenesis',)
('Alien',)
*/