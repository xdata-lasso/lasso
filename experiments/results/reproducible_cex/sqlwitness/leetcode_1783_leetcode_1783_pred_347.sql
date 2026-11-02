-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default1'), (0, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 0, NULL, 2, NULL), (2, NULL, 2, 0, 2), (3, 0, 2, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default2', 4)
(2, 'default1', 5)
*/

-- Prediction Query
WITH TMP AS (SELECT WIMBLEDON AS CHAM_PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS CHAM_PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS CHAM_PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS CHAM_PLAYER_ID FROM CHAMPIONSHIPS) SELECT T2.PLAYER_ID, T2.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM TMP AS T1 LEFT JOIN PLAYERS AS T2 ON T1.CHAM_PLAYER_ID = T2.PLAYER_ID GROUP BY 1, 2;

/*
Prediction Result:
(None, None, 3)
(0, 'default2', 4)
(2, 'default1', 5)
*/