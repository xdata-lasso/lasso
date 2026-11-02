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
SELECT P1.PLAYER_ID, P1.PLAYER_NAME, SUM(P1.PLAYER_ID = C1.WIMBLEDON) + SUM(P1.PLAYER_ID = C1.FR_OPEN) + SUM(P1.PLAYER_ID = C1.US_OPEN) + SUM(P1.PLAYER_ID = C1.AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P1 JOIN CHAMPIONSHIPS AS C1 ON P1.PLAYER_ID = C1.WIMBLEDON OR P1.PLAYER_ID = C1.FR_OPEN OR P1.PLAYER_ID = C1.US_OPEN OR P1.PLAYER_ID = C1.AU_OPEN GROUP BY P1.PLAYER_ID;

/*
Prediction Result:
(1, 'Active_Champion', None)
*/