-- Schema DDL
CREATE TABLE "Movie" ("mID" INTEGER PRIMARY KEY, "title" TEXT, "year" INTEGER, "director" TEXT);

CREATE TABLE "Reviewer" ("rID" INTEGER PRIMARY KEY, "name" TEXT);

CREATE TABLE "Rating" ("rID" INTEGER, "mID" INTEGER, "stars" INTEGER, "ratingDate" DATE, FOREIGN KEY ("rID") REFERENCES "Reviewer" ("rID"), FOREIGN KEY ("mID") REFERENCES "Movie" ("mID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO reviewer (rid, name) VALUES (1, NULL), (0, 'default1'), (2, 'default1');
INSERT INTO movie (mid, title, year, director) VALUES (2, 'default2', 1, 'default2'), (1, 'default1', 2, 'default2'), (0, NULL, 0, 'default1'), (3, 'default1', NULL, 'default2'), (4, 'default1', 1, NULL);
INSERT INTO rating (rid, mid, stars, ratingdate) VALUES (2, 0, 2, NULL), (NULL, NULL, 2, '2023-01-01'), (1, NULL, 2, '2023-01-01'), (0, 1, 1, NULL), (1, 1, 1, '2023-01-01'), (0, 0, 1, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM movie AS LHS WHERE NOT EXISTS(SELECT 1 FROM rating AS RHS WHERE (LHS.mid = RHS.mid))) ORDER BY title;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT title FROM Movie WHERE NOT mID IN (SELECT mID FROM Rating);

/*
Prediction Result:
*/