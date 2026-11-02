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
INSERT INTO MOVIE VALUES (0, 10, 0, 9);
INSERT INTO MOVIE VALUES (1, 11, 0, 8);
INSERT INTO REVIEWER VALUES (-1, 0);
INSERT INTO REVIEWER VALUES (0, 0);
INSERT INTO RATING VALUES (0, 0, 0, '0001-01-01');
INSERT INTO RATING VALUES (0, 0, 0, '0001-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR FROM (SELECT * FROM (SELECT * FROM movie ORDER BY YEAR DESC, movie.mid NULLS LAST) LIMIT 4);

/*
Gold Result:
('10', 0)
('11', 0)
*/

-- Prediction Query
SELECT T1.title, T1.year FROM Movie AS T1 JOIN Movie AS T2 ON T1.director = T2.director WHERE T1.title <> T2.title;

/*
Prediction Result:
*/