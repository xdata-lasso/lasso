-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (mid, title, year, director) VALUES (1, 'James Cameron', 1999, NULL), (2001, 'James Cameron', 2000, 'James Cameron'), (1999, NULL, 0, 'default1'), (2000, NULL, 2001, 'James Cameron');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' AND YEAR >= 2000) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
(None,)
('James Cameron',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' AND YEAR > 2000;

/*
Prediction Result:
(None,)
*/