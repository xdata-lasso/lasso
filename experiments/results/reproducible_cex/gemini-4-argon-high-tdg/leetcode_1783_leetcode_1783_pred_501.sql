-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Players (player_id, player_name) VALUES (1, 'Active_Champion');
INSERT INTO Players (player_id, player_name) VALUES (2020, 'Year_ID_Trap_Zero_Wins');
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2020, NULL, 1, NULL, 1);
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2021, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'Active_Champion', 2)
*/

-- Prediction Query
WITH CTE AS (SELECT WIMBLEDON AS PLAY, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY WIMBLEDON UNION ALL SELECT FR_OPEN AS PLAY, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY FR_OPEN UNION ALL SELECT US_OPEN AS PLAY, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY US_OPEN UNION ALL SELECT AU_OPEN AS PLAY, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY AU_OPEN) SELECT CTE.PLAY AS PLAYER_ID, PLAYERS.PLAYER_NAME, SUM(CTE.NUM) AS GRAND_SLAMS_COUNT FROM CTE LEFT JOIN PLAYERS ON CTE.PLAY = PLAYERS.PLAYER_ID GROUP BY CTE.PLAY;

/*
Prediction Result:
(None, None, 6)
(1, 'Active_Champion', 2)
*/