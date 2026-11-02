-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (64, '65');
INSERT INTO "Players" ("player_id", "player_name") VALUES (60, '61');
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (25, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT DISTINCT WIMBLEDON AS PLAYER_ID, COUNT(WIMBLEDON) AS GAME FROM CHAMPIONSHIPS GROUP BY 1), T2 AS (SELECT DISTINCT FR_OPEN AS PLAYER_ID, COUNT(FR_OPEN) AS GAME FROM CHAMPIONSHIPS GROUP BY 1), T3 AS (SELECT DISTINCT US_OPEN AS PLAYER_ID, COUNT(US_OPEN) AS GAME FROM CHAMPIONSHIPS GROUP BY 1), T4 AS (SELECT DISTINCT AU_OPEN AS PLAYER_ID, COUNT(AU_OPEN) AS GAME FROM CHAMPIONSHIPS GROUP BY 1) SELECT P.PLAYER_ID, P.PLAYER_NAME, COALESCE(T1.GAME, 0) + COALESCE(T2.GAME, 0) + COALESCE(T3.GAME, 0) + COALESCE(T4.GAME, 0) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P LEFT JOIN T1 ON P.PLAYER_ID = T1.PLAYER_ID LEFT JOIN T2 ON P.PLAYER_ID = T2.PLAYER_ID LEFT JOIN T3 ON P.PLAYER_ID = T3.PLAYER_ID LEFT JOIN T4 ON P.PLAYER_ID = T4.PLAYER_ID WHERE COALESCE(T1.GAME, 0) + COALESCE(T2.GAME, 0) + COALESCE(T3.GAME, 0) + COALESCE(T4.GAME, 0) > 0;

/*
Prediction Result:
*/