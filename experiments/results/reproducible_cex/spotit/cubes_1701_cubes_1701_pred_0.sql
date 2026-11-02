-- Schema DDL
CREATE TABLE "MOVIE" (
    "MID" INT,
    "TITLE" TEXT,
    "YEAR" INT,
    "DIRECTOR" TEXT,
    PRIMARY KEY ("MID")
);
CREATE TABLE "REVIEWER" (
    "RID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("RID")
);
CREATE TABLE "RATING" (
    "RID" INT,
    "MID" INT,
    "STARS" INT,
    "RATINGDATE" DATE,
    FOREIGN KEY ("RID") REFERENCES "REVIEWER"("RID"),
    FOREIGN KEY ("MID") REFERENCES "MOVIE"("MID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MOVIE VALUES (1, 14, 0, 2852685057514270163);
INSERT INTO MOVIE VALUES (0, 8, 0, 2852685057514270164);
INSERT INTO REVIEWER VALUES (1, 0);
INSERT INTO REVIEWER VALUES (0, 0);
INSERT INTO RATING VALUES (1, 0, 0, '0001-01-01');
INSERT INTO RATING VALUES (1, 0, 0, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT director FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.director AS director_other, RHS.n AS n FROM movie AS LHS CROSS JOIN (SELECT * FROM (SELECT director, COUNT(*) AS n FROM movie GROUP BY director) WHERE (n <= 1)) AS RHS) WHERE (director = director_other) ORDER BY director;

/*
Gold Result:
('2852685057514270163',)
('2852685057514270164',)
*/

-- Prediction Query
SELECT director FROM Movie WHERE director <> 'null' GROUP BY director HAVING COUNT(*) = 1;

/*
Prediction Result:
('2852685057514270163',)
('2852685057514270164',)
*/