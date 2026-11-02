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
WITH T1 AS (SELECT A.PLAYER_ID, A.PLAYER_NAME, SUM(A.PLAYER_ID = B.WIMBLEDON) + SUM(A.PLAYER_ID = B.FR_OPEN) + SUM(A.PLAYER_ID = B.US_OPEN) + SUM(A.PLAYER_ID = B.AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS A JOIN CHAMPIONSHIPS AS B ON (A.PLAYER_ID = B.WIMBLEDON) OR (A.PLAYER_ID = B.FR_OPEN) OR (A.PLAYER_ID = B.US_OPEN) OR (A.PLAYER_ID = B.AU_OPEN) GROUP BY PLAYER_ID) SELECT PLAYER_ID, PLAYER_NAME, GRAND_SLAMS_COUNT FROM T1;

/*
Prediction Result:
(1, 'Active_Champion', None)
*/