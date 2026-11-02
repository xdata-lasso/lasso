-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default2'), (0, NULL), (-1, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, -1, 0, -1, 1), (0, 0, 0, NULL, -1), (-1, 0, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 3)
(0, None, 4)
(1, 'default2', 2)
*/

-- Prediction Query
WITH T AS (SELECT WIMBLEDON AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY WIMBLEDON), T2 AS (SELECT FR_OPEN AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY FR_OPEN), T3 AS (SELECT US_OPEN AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY US_OPEN), T4 AS (SELECT AU_OPEN AS PLAYER_ID, COUNT(*) AS SLAMS_COUNT FROM CHAMPIONSHIPS GROUP BY AU_OPEN), TEMP AS (SELECT * FROM T UNION ALL SELECT * FROM T2 UNION ALL SELECT * FROM T3 UNION ALL SELECT * FROM T4) SELECT TEMP.PLAYER_ID, PLAYER_NAME, SUM(SLAMS_COUNT) AS GRAND_SLAMS_COUNT FROM TEMP LEFT JOIN PLAYERS ON TEMP.PLAYER_ID = PLAYERS.PLAYER_ID GROUP BY TEMP.PLAYER_ID;

/*
Prediction Result:
(None, None, 3)
(-1, None, 3)
(0, None, 4)
(1, 'default2', 2)
*/