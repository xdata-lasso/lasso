-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, 'default2'), (-1, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (1, -1, -1, -1, -1), (0, NULL, 0, -1, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 6)
(0, 'default2', 1)
*/

-- Prediction Query
WITH CTE_ALL AS (SELECT YEAR, WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS) SELECT CTE_ALL.PLAYER_ID, PLAYERS.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM CTE_ALL INNER JOIN PLAYERS ON CTE_ALL.PLAYER_ID = PLAYERS.PLAYER_ID GROUP BY 1, 2 ORDER BY 3, CTE_ALL.PLAYER_ID NULLS LAST, PLAYERS.PLAYER_NAME NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(0, 'default2', 1)
(-1, 'default2', 6)
*/