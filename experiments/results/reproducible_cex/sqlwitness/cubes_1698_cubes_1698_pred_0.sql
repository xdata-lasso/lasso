-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (2000, 'default1'), (0, NULL), (1999, 'Brittany Harris'), (2001, 'Brittany Harris'), (1, 'default1'), (2, 'default2'), (3, NULL), (4, 'Brittany Harris'), (5, 'Brittany Harris'), (6, NULL), (7, NULL);
INSERT INTO movie (mid, title, year, director) VALUES (0, 'default1', 1999, 'default2'), (1999, 'Brittany Harris', 2000, NULL), (1, 'default2', NULL, 'Brittany Harris'), (2001, 'default1', 1999, 'default2'), (2000, 'default2', NULL, 'default1'), (2, 'default1', 1, 'Brittany Harris'), (3, NULL, 1, 'default1'), (4, NULL, 1, NULL), (5, 'default2', 0, 'default2'), (6, 'Brittany Harris', 2000, 'Brittany Harris');
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (2, NULL, 2001, '2023-01-02'), (4, NULL, NULL, '2023-01-02'), (2001, 1999, 2001, NULL), (6, 4, 2000, NULL), (1, 1999, NULL, '2023-01-02'), (1999, 3, 0, NULL), (1999, 0, 1, '2023-01-02'), (2, 0, 2001, '2023-01-02'), (2001, 2001, 1999, NULL), (5, 4, 1999, NULL), (4, NULL, 2001, '2023-01-02'), (2001, 6, 2001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "title" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "LHS"."rid" AS "rid", "LHS"."name" AS "name", "RHS"."stars" AS "stars", "RHS"."ratingdate" AS "ratingdate" FROM (SELECT "LHS"."mid" AS "mid", "LHS"."title" AS "title", "LHS"."year" AS "year", "LHS"."director" AS "director", "RHS"."rid" AS "rid", "RHS"."name" AS "name" FROM "movie" AS "LHS" CROSS JOIN "reviewer" AS "RHS") AS "LHS" INNER JOIN "rating" AS "RHS" ON ("LHS"."mid" = "RHS"."mid" AND "LHS"."rid" = "RHS"."rid")) WHERE ("name" = 'Brittany Harris' OR YEAR > 2000) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('Brittany Harris',)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID JOIN Reviewer AS T3 ON T1.rID = T3.rID WHERE T3.name = 'Brittany Harris' OR T2.year > 2000;

/*
Prediction Result:
('Brittany Harris',)
(None,)
('default1',)
*/