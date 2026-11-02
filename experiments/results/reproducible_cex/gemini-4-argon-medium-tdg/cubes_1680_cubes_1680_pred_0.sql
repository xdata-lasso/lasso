-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests projection (SELECT vs SELECT DISTINCT), ordering by director (ASC vs DESC), and NULLS FIRST vs NULLS LAST on director
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (10, 'Avatar', 2009, 'Zack Snyder');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (20, 'Avatar', 2009, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (30, 'Avatar', 2022, 'James Cameron');
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (40, 'Avatar', 2000, NULL);
INSERT INTO "Movie" ("mID", "title", "year", "director") VALUES (50, 'Avatar', 2005, 'Aaron Sorkin');
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
(None,)
('Aaron Sorkin',)
*/