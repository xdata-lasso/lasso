-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default1'), (2, 'default1'), (1, NULL), (0, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 0, 2, 0, -1), (-1, 1, 2, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 1)
(0, 'default1', 2)
(1, None, 1)
(2, 'default1', 3)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(PLAYER_ID = WIMBLEDON) + SUM(PLAYER_ID = FR_OPEN) + SUM(PLAYER_ID = US_OPEN) + SUM(PLAYER_ID = AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS ON PLAYER_ID = WIMBLEDON OR PLAYER_ID = FR_OPEN OR PLAYER_ID = US_OPEN OR PLAYER_ID = AU_OPEN GROUP BY PLAYER_ID;

/*
Prediction Result:
(-1, 'default1', 1)
(0, 'default1', 2)
(1, None, None)
(2, 'default1', 3)
*/