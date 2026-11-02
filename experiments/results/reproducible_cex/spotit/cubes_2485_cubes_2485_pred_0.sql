-- Schema DDL
CREATE TABLE "STUDENT" (
    "STUID" INT,
    "LNAME" TEXT,
    "FNAME" TEXT,
    "AGE" INT,
    "SEX" TEXT,
    "MAJOR" INT,
    "ADVISOR" INT,
    "CITY_CODE" TEXT,
    PRIMARY KEY ("STUID")
);
CREATE TABLE "VIDEO_GAMES" (
    "GAMEID" INT,
    "GNAME" TEXT,
    "GTYPE" TEXT,
    PRIMARY KEY ("GAMEID")
);
CREATE TABLE "PLAYS_GAMES" (
    "STUID" INT,
    "GAMEID" INT,
    "HOURS_PLAYED" INT,
    FOREIGN KEY ("STUID") REFERENCES "STUDENT"("STUID"),
    FOREIGN KEY ("GAMEID") REFERENCES "VIDEO_GAMES"("GAMEID")
);
CREATE TABLE "SPORTSINFO" (
    "STUID" INT,
    "SPORTNAME" TEXT,
    "HOURSPERWEEK" INT,
    "GAMESPLAYED" INT,
    "ONSCHOLARSHIP" TEXT,
    FOREIGN KEY ("STUID") REFERENCES "STUDENT"("STUID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (-1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STUDENT VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO VIDEO_GAMES VALUES (1, 16, 17);
INSERT INTO VIDEO_GAMES VALUES (0, -1, 18);
INSERT INTO PLAYS_GAMES VALUES (-1, 0, -1);
INSERT INTO PLAYS_GAMES VALUES (-1, 0, 1000);
INSERT INTO SPORTSINFO VALUES (-1, 0, 0, 0, 0);
INSERT INTO SPORTSINFO VALUES (-1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT gname FROM (SELECT gname, SUM(hours_played) AS sumhours_played FROM (SELECT * FROM (SELECT LHS.gameid AS gameid, LHS.gname AS gname, LHS.gtype AS gtype, RHS.stuid AS stuid, RHS.hours_played AS hours_played FROM video_games AS LHS INNER JOIN plays_games AS RHS ON (LHS.gameid = RHS.gameid)) WHERE (hours_played >= 1000)) GROUP BY gname) ORDER BY gname;

/*
Gold Result:
('-1',)
*/

-- Prediction Query
SELECT gname FROM Plays_games AS T1 JOIN Video_games AS T2 ON T1.gameid = T2.gameid GROUP BY T1.gameid HAVING SUM(hours_played) >= 1000;

/*
Prediction Result:
*/