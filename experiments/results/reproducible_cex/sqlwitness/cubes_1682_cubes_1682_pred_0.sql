-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (4, 'default1'), (5, 'default2'), (1, 'default2'), (3, 'default1'), (0, 'default2'), (2, 'default1'), (6, 'default2'), (7, 'default2'), (8, 'default1'), (9, NULL), (10, 'default2');
INSERT INTO movie (mid, title, year, director) VALUES (3, 'default1', 0, 'default1'), (4, NULL, 5, 'default1'), (1, 'default2', 0, NULL), (5, NULL, 5, 'default2'), (0, 'default1', NULL, 'default2'), (2, 'default1', 4, 'default2'), (6, 'default1', 3, 'default2'), (7, 'default2', 4, 'default2'), (8, 'default2', 4, 'default1'), (9, NULL, 5, NULL), (10, NULL, 0, NULL), (11, 'default1', 4, NULL);
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (2, 3, 4, '2023-01-01'), (10, 7, 1, '2023-01-01'), (1, 11, 4, '2023-01-01'), (0, 7, NULL, '2023-01-02'), (7, 2, 5, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT rid FROM rating WHERE (stars <> 4) ORDER BY rid, rating.mid NULLS LAST, rating.stars NULLS LAST, rating.ratingdate NULLS LAST;

/*
Gold Result:
(7,)
(10,)
*/

-- Prediction Query
SELECT rID FROM Rating WHERE stars <> 4;

/*
Prediction Result:
(10,)
(7,)
*/