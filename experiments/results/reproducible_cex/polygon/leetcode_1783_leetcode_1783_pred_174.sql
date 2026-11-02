-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (33, NULL);
INSERT INTO "Players" ("player_id", "player_name") VALUES (32, '40');
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (34, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T.PLAYER_ID, T.PLAYER_NAME, SUM(T.CT) AS GRAND_SLAMS_COUNT FROM (SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS CT FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.WIMBLEDON GROUP BY P.PLAYER_ID UNION ALL SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS CT FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.FR_OPEN GROUP BY P.PLAYER_ID UNION ALL SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS CT FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.US_OPEN GROUP BY P.PLAYER_ID UNION ALL SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS CT FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.AU_OPEN GROUP BY P.PLAYER_ID) AS T GROUP BY T.PLAYER_ID;

/*
Prediction Result:
*/