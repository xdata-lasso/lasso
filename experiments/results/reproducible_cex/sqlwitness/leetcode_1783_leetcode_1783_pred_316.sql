-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default1'), (0, NULL), (-1, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, 0, 2, 0, 0), (0, 2, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, None, 3)
(2, 'default1', 2)
*/

-- Prediction Query
WITH SLAMZ AS (SELECT WIMBLEDON AS SLAMMER, 1 AS TOTAL FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS SLAMMER, 1 AS TOTAL FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS SLAMMER, 1 AS TOTAL FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS SLAMMER, 1 AS TOTAL FROM CHAMPIONSHIPS) SELECT SLAMMER AS PLAYER_ID, PLAYER_NAME, SUM(TOTAL) AS GRAND_SLAMS_COUNT FROM SLAMZ LEFT JOIN PLAYERS ON SLAMMER = PLAYERS.PLAYER_ID GROUP BY SLAMMER;

/*
Prediction Result:
(None, None, 3)
(0, None, 3)
(2, 'default1', 2)
*/