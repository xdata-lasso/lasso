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
INSERT INTO ARTIST VALUES (-1, 15, 0, -1, 16);
INSERT INTO ARTIST VALUES (0, 20, 0, -2, 21);
INSERT INTO VOLUME VALUES (1, -1, 17, 18, 3, 19);
INSERT INTO VOLUME VALUES (0, 0, 22, 23, 3, 24);
INSERT INTO MUSIC_FESTIVAL VALUES (-1, 1, 0, 0, 0, 0);
INSERT INTO MUSIC_FESTIVAL VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT famous_title FROM (SELECT LHS.artist_id AS artist_id, LHS.artist AS artist, LHS.age AS age, LHS.famous_title AS famous_title, LHS.famous_release_date AS famous_release_date, RHS.volume_id AS volume_id, RHS.volume_issue AS volume_issue, RHS.issue_date AS issue_date, RHS.weeks_on_top AS weeks_on_top, RHS.song AS song FROM artist AS LHS INNER JOIN volume AS RHS ON (LHS.artist_id = RHS.artist_id)) WHERE (weeks_on_top > 2.0) ORDER BY famous_title;

/*
Gold Result:
('-1',)
('-2',)
*/

-- Prediction Query
SELECT T1.Famous_Title FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T2.Weeks_on_Top > 2 INTERSECT SELECT T1.Famous_Title FROM artist AS T1 JOIN volume AS T2 ON T1.Artist_ID = T2.Artist_ID WHERE T2.Weeks_on_Top < 2;

/*
Prediction Result:
*/