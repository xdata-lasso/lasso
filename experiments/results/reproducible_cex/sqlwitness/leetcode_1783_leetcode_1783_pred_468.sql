-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, NULL), (1, NULL), (-1, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, 1, 1, 1, 2), (0, 1, NULL, NULL, -1), (-1, NULL, NULL, 2, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 2)
(1, None, 4)
(2, None, 2)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, (SUM((WIMBLEDON = PLAYER_ID) + (FR_OPEN = PLAYER_ID) + (US_OPEN = PLAYER_ID) + (AU_OPEN = PLAYER_ID))) AS GRAND_SLAMS_COUNT FROM PLAYERS CROSS JOIN CHAMPIONSHIPS GROUP BY PLAYER_ID HAVING GRAND_SLAMS_COUNT > 0;

/*
Prediction Result:
(1, None, 3)
(2, None, 1)
*/