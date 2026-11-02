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
SELECT T.PLAYER AS PLAYER_ID, PLAYERS.PLAYER_NAME, SUM(WIN_NUMBER) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER, COUNT(WIMBLEDON) AS WIN_NUMBER FROM CHAMPIONSHIPS GROUP BY WIMBLEDON UNION ALL SELECT FR_OPEN AS PLAYER, COUNT(FR_OPEN) AS WIN_NUMBER FROM CHAMPIONSHIPS GROUP BY FR_OPEN UNION ALL SELECT US_OPEN AS PLAYER, COUNT(US_OPEN) AS WIN_NUMBER FROM CHAMPIONSHIPS GROUP BY US_OPEN UNION ALL SELECT AU_OPEN AS PLAYER, COUNT(AU_OPEN) AS WIN_NUMBER FROM CHAMPIONSHIPS GROUP BY AU_OPEN) AS T LEFT JOIN PLAYERS ON T.PLAYER = PLAYERS.PLAYER_ID GROUP BY T.PLAYER ORDER BY SUM(WIN_NUMBER), PLAYER_ID NULLS LAST, PLAYERS.PLAYER_NAME NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(None, None, 0)
(1, 'Active_Champion', 2)
*/