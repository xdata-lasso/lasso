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
INSERT INTO MOVIE VALUES (0, -2, 0, 11);
INSERT INTO MOVIE VALUES (-1, -1, 0, 12);
INSERT INTO REVIEWER VALUES (1, 0);
INSERT INTO REVIEWER VALUES (0, 0);
INSERT INTO RATING VALUES (0, -1, 6, '0001-01-01');
INSERT INTO RATING VALUES (1, 0, 6, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.mid AS mid, LHS.title AS title, LHS.year AS YEAR, LHS.director AS director, RHS.rid AS rid, RHS.stars AS stars, RHS.ratingdate AS ratingdate FROM movie AS LHS INNER JOIN (SELECT * FROM rating WHERE (stars >= 3 OR stars >= 5)) AS RHS ON (LHS.mid = RHS.mid)) ORDER BY title;

/*
Gold Result:
('-1',)
('-2',)
*/

-- Prediction Query
SELECT T2.title FROM Rating AS T1 JOIN Movie AS T2 ON T1.mID = T2.mID WHERE T1.stars BETWEEN 3 AND 5;

/*
Prediction Result:
*/