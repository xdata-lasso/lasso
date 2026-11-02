-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Movie (mID, title, year, director) VALUES (1, 'The Shining', 1980, 'Stanley Kubrick');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
('The Shining',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
*/