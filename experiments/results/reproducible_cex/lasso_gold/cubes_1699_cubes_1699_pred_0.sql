-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1011, 'Therapeutic radiographer', 1979, 'James Cameron');
INSERT INTO "movie" ("mid", "title", "year", "director") VALUES (1012, 'Pharmacist, hospital', -1980, 'James Cameron');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('Pharmacist, hospital',)
('Therapeutic radiographer',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
('Therapeutic radiographer',)
('Pharmacist, hospital',)
*/