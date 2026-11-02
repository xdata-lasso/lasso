-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (mid, title, year, director) VALUES (1, 'default2', 1, 'default2'), (0, 'Steven Spielberg', 1, 'Steven Spielberg'), (2, NULL, NULL, 'Steven Spielberg'), (3, NULL, NULL, 'Steven Spielberg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "movie" WHERE ("director" = 'Steven Spielberg') ORDER BY title, movie.mid NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Steven Spielberg',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE director = 'Steven Spielberg';

/*
Prediction Result:
('Steven Spielberg',)
(None,)
(None,)
*/