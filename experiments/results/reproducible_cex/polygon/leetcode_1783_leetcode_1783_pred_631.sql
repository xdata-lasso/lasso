-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (25, 'US_OPEN26');
INSERT INTO "Players" ("player_id", "player_name") VALUES (24, 'US_OPEN26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT YEAR, WIMBLEDON AS PLAYER_ID, 'WIMBLEDON' AS TITLE FROM CHAMPIONSHIPS UNION SELECT YEAR, FR_OPEN AS PLAYER_ID, 'FR_OPEN' AS TITLE FROM CHAMPIONSHIPS UNION SELECT YEAR, US_OPEN AS PLAYER_ID, 'US_OPEN' AS TITLE FROM CHAMPIONSHIPS UNION SELECT YEAR, AU_OPEN AS PLAYER_ID, 'AU_OPEN' AS TITLE FROM CHAMPIONSHIPS) SELECT C.PLAYER_ID, P.PLAYER_NAME, COUNT(C.TITLE) AS GRAND_SLAMS_COUNT FROM CTE AS C LEFT JOIN PLAYERS AS P ON P.PLAYER_ID = C.PLAYER_ID GROUP BY C.PLAYER_ID;

/*
Prediction Result:
*/