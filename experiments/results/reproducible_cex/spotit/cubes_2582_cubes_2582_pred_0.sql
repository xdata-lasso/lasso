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
INSERT INTO ARTIST VALUES (-1, 0, 0, 0, 0);
INSERT INTO ARTIST VALUES (0, 0, 0, 0, 0);
INSERT INTO VOLUME VALUES (0, 0, 20, 21, NULL, 22);
INSERT INTO VOLUME VALUES (-1, -1, 26, 27, 2, 28);
INSERT INTO MUSIC_FESTIVAL VALUES (0, 0, 17, -2, 18, 19);
INSERT INTO MUSIC_FESTIVAL VALUES (-1, -1, 23, -3, 24, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_ceremony FROM (SELECT volume_id, volume_issue, issue_date, weeks_on_top, song, artist_id, music_festival, date_of_ceremony, category, RESULT, volume_id AS volume FROM (SELECT LHS.volume_id AS volume_id, LHS.volume_issue AS volume_issue, LHS.issue_date AS issue_date, LHS.weeks_on_top AS weeks_on_top, LHS.song AS song, LHS.artist_id AS artist_id, RHS.music_festival AS music_festival, RHS.date_of_ceremony AS date_of_ceremony, RHS.category AS category, RHS.result AS RESULT FROM volume AS LHS INNER JOIN music_festival AS RHS ON (LHS.volume_id = RHS.volume AND LHS.artist_id = RHS.id))) ORDER BY date_of_ceremony;

/*
Gold Result:
('-2',)
('-3',)
*/

-- Prediction Query
SELECT T1.Date_of_ceremony FROM music_festival AS T1 JOIN volume AS T2 ON T1.Volume = T2.Volume_ID WHERE T2.Weeks_on_Top > 2;

/*
Prediction Result:
*/