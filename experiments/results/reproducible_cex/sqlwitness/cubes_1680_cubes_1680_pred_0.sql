-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (mid, title, year, director) VALUES (0, 'Avatar', NULL, 'default2'), (1, 'Avatar', NULL, 'default1'), (2, NULL, NULL, 'default2'), (3, 'Avatar', NULL, 'Avatar'), (4, 'default1', 0, 'Avatar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "director" FROM "movie" WHERE ("title" = 'Avatar') ORDER BY director, movie.mid NULLS LAST;

/*
Gold Result:
('Avatar',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT director FROM Movie WHERE title = 'Avatar';

/*
Prediction Result:
('default2',)
('default1',)
('Avatar',)
*/