-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (1, 'Daniel Lewis'), (0, 'Daniel Lewis'), (2, NULL), (3, NULL), (4, 'default2'), (5, 'Daniel Lewis'), (6, 'default2'), (7, 'default2'), (8, NULL), (9, NULL), (10, 'default2'), (11, 'default2'), (12, 'Daniel Lewis'), (13, 'default2'), (14, 'Daniel Lewis'), (15, NULL), (16, 'Daniel Lewis'), (17, NULL), (18, 'default1'), (19, NULL), (20, 'default1'), (21, 'Daniel Lewis'), (22, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "rid" FROM "reviewer" WHERE ("name" = 'Daniel Lewis') ORDER BY rid;

/*
Gold Result:
(0,)
(1,)
(5,)
(12,)
(14,)
(16,)
(21,)
*/

-- Prediction Query
SELECT rID FROM Reviewer WHERE name = 'Daniel Lewis';

/*
Prediction Result:
(0,)
(1,)
(5,)
(12,)
(14,)
(16,)
(21,)
*/