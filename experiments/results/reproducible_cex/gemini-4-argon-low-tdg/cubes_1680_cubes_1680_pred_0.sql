-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (1, 'Avatar', 2009, 'Zack Snyder');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (2, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (3, 'Avatar', 2022, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (4, 'Avatar', 2005, 'Aaron Sorkin');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (5, 'Avatar', 2010, NULL);
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (6, 'Inception', 2010, 'Christopher Nolan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "director" FROM "movie" WHERE ("title" = 'Avatar') ORDER BY director, movie.mid NULLS LAST;

/*
Gold Result:
(None,)
('Aaron Sorkin',)
('James Cameron',)
('James Cameron',)
('Zack Snyder',)
*/

-- Prediction Query
SELECT director FROM Movie WHERE title = 'Avatar';

/*
Prediction Result:
('Zack Snyder',)
('James Cameron',)
('James Cameron',)
('Aaron Sorkin',)
(None,)
*/