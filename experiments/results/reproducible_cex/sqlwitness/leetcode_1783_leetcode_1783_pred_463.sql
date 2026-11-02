-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default2'), (0, NULL), (2, 'default1'), (1, 'default2'), (3, 'default1'), (4, 'default2'), (5, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (1, 0, NULL, 4, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 1)
(0, None, 1)
(4, 'default2', 1)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(WIMBLEDON = PLAYER_ID) + SUM(FR_OPEN = PLAYER_ID) + SUM(US_OPEN = PLAYER_ID) + SUM(AU_OPEN = PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS LEFT JOIN CHAMPIONSHIPS ON PLAYERS.PLAYER_ID = CHAMPIONSHIPS.WIMBLEDON OR PLAYERS.PLAYER_ID = CHAMPIONSHIPS.FR_OPEN OR PLAYERS.PLAYER_ID = CHAMPIONSHIPS.US_OPEN OR PLAYERS.PLAYER_ID = CHAMPIONSHIPS.AU_OPEN GROUP BY PLAYER_ID HAVING COUNT(YEAR) > 0;

/*
Prediction Result:
(-1, 'default2', None)
(0, None, None)
(4, 'default2', None)
*/