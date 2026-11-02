-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (mid, title, year, director) VALUES (1, NULL, 1980, 'default1'), (0, 'James Cameron', 1, 'default1'), (1981, 'default2', NULL, NULL), (1979, 'James Cameron', 1981, NULL), (1980, NULL, 1980, 'James Cameron'), (2, NULL, 1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'James Cameron' OR YEAR <= 1980) ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(None,)
('James Cameron',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'James Cameron' OR YEAR < 1980;

/*
Prediction Result:
('James Cameron',)
(None,)
(None,)
*/