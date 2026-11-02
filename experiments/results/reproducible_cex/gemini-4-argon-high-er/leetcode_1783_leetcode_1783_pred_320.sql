-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Players (player_id, player_name) VALUES (1, 'A');
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2020, 1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'A', 3)
*/

-- Prediction Query
WITH T AS (SELECT WIMBLEDON AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY WIMBLEDON), T2 AS (SELECT FR_OPEN AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY FR_OPEN), T3 AS (SELECT US_OPEN AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY US_OPEN), T4 AS (SELECT AU_OPEN AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY AU_OPEN), TEMP AS (SELECT * FROM T UNION ALL SELECT * FROM T2 UNION ALL SELECT * FROM T3 UNION ALL SELECT * FROM T4) SELECT TEMP.PLAYER_ID, PLAYER_NAME, SUM(SLAMS_COUNT) AS GRAND_SLAMS_COUNT FROM TEMP LEFT JOIN PLAYERS ON TEMP.PLAYER_ID = PLAYERS.PLAYER_ID GROUP BY TEMP.PLAYER_ID;

/*
Prediction Result:
(None, None, 1)
(1, 'A', 3)
*/