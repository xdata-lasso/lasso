-- Schema DDL
CREATE TABLE "ARTIST" (
    "ARTIST_ID" INT,
    "ARTIST" TEXT,
    "AGE" INT,
    "FAMOUS_TITLE" TEXT,
    "FAMOUS_RELEASE_DATE" TEXT,
    PRIMARY KEY ("ARTIST_ID")
);
CREATE TABLE "VOLUME" (
    "VOLUME_ID" INT,
    "ARTIST_ID" INT,
    "VOLUME_ISSUE" TEXT,
    "ISSUE_DATE" TEXT,
    "WEEKS_ON_TOP" FLOAT,
    "SONG" TEXT,
    PRIMARY KEY ("VOLUME_ID"),
    FOREIGN KEY ("ARTIST_ID") REFERENCES "ARTIST"("ARTIST_ID")
);
CREATE TABLE "MUSIC_FESTIVAL" (
    "ID" INT,
    "VOLUME" INT,
    "MUSIC_FESTIVAL" TEXT,
    "DATE_OF_CEREMONY" TEXT,
    "CATEGORY" TEXT,
    "RESULT" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("VOLUME") REFERENCES "VOLUME"("VOLUME_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ARTIST VALUES (0, 25, 24, 26, 27);
INSERT INTO ARTIST VALUES (1, 28, 23, 29, 30);
INSERT INTO VOLUME VALUES (-1, 1, 13, 14, -2, 15);
INSERT INTO VOLUME VALUES (0, 0, 16, 17, 0, 18);
INSERT INTO MUSIC_FESTIVAL VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO MUSIC_FESTIVAL VALUES (1, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weeks_on_top AS avg_t2_weeks_on_top_ FROM (SELECT LHS.age AS age, LHS.artist_id AS artist_id, LHS.meanage AS meanage, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM (SELECT * FROM (SELECT age, artist_id, AVG(age) AS meanage FROM artist GROUP BY age, artist_id) WHERE (age < 25 AND meanage >= age)) AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) ORDER BY avg_t2_weeks_on_top_;

/*
Gold Result:
(-2.0,)
(0.0,)
*/

-- Prediction Query
SELECT AVG(T2.Weeks_on_Top) FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T1.age <= 25;

/*
Prediction Result:
(-1.0,)
*/