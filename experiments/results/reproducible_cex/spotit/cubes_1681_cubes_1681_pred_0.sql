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
INSERT INTO MOVIE VALUES (-2147483647, 0, -2147483648, 0);
INSERT INTO MOVIE VALUES (-2147483648, 0, -2147483648, 0);
INSERT INTO REVIEWER VALUES (-2147483648, 0);
INSERT INTO REVIEWER VALUES (-2147483647, 0);
INSERT INTO RATING VALUES (-2147483648, -2147483647, NULL, '0001-01-01');
INSERT INTO RATING VALUES (-2147483647, -2147483647, 2, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, meanstars AS avg_t1_stars_ FROM (SELECT LHS.rid AS rid, LHS.name AS name, RHS.meanstars AS meanstars FROM reviewer AS LHS INNER JOIN (SELECT rid, AVG(stars) AS meanstars FROM rating GROUP BY rid) AS RHS ON (LHS.rid = RHS.rid)) ORDER BY name, avg_t1_stars_ NULLS LAST;

/*
Gold Result:
('0', 2.0)
('0', None)
*/

-- Prediction Query
SELECT T2.name, AVG(T1.stars) FROM Rating AS T1 JOIN Reviewer AS T2 ON T1.rID = T2.rID GROUP BY T2.name;

/*
Prediction Result:
('0', 2.0)
*/