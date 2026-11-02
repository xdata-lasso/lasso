-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (3, 'default2'), (2, 'default2'), (1, NULL), (0, 'default1'), (-1, 'default1'), (4, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (3, NULL, 4, 4, 1), (-1, 2, 0, NULL, NULL), (1, 3, 2, 3, 3), (0, 2, 1, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default1', 1)
(1, None, 3)
(2, 'default2', 4)
(3, 'default2', 3)
(4, 'default1', 2)
*/

-- Prediction Query
WITH CTE AS (SELECT YEAR, WIMBLEDON AS TITLE FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, FR_OPEN AS TITLE FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, US_OPEN AS TITLE FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, AU_OPEN AS TITLE FROM CHAMPIONSHIPS) SELECT PLAYER_ID, PLAYER_NAME, COUNT(TITLE) AS GRAND_SLAMS_COUNT FROM CTE JOIN PLAYERS ON CTE.TITLE = PLAYERS.PLAYER_ID GROUP BY 1 ORDER BY 2, PLAYER_ID NULLS LAST, PLAYER_NAME NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(1, None, 3)
(0, 'default1', 1)
(4, 'default1', 2)
(2, 'default2', 4)
(3, 'default2', 3)
*/