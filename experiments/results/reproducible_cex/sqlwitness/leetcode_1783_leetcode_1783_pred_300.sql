-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, 'default1'), (-1, 'default2'), (3, NULL), (1, 'default2'), (2, NULL), (4, NULL), (5, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, -1, 5, 3, 5), (3, 0, 4, 0, 2), (1, 4, 4, 1, 0), (0, 5, 3, 4, NULL), (-1, NULL, -1, 5, -1), (4, 3, 2, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 3)
(0, 'default1', 3)
(1, 'default2', 1)
(2, None, 2)
(3, None, 3)
(4, None, 4)
(5, 'default2', 4)
*/

-- Prediction Query
WITH CTE AS (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS) SELECT A.PLAYER_ID, PLAYER_NAME, COUNT(B.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS A JOIN CTE AS B USING (PLAYER_ID) GROUP BY 1, 2 ORDER BY GRAND_SLAMS_COUNT, A.PLAYER_ID NULLS LAST, PLAYER_NAME NULLS LAST;

/*
Prediction Result:
(1, 'default2', 1)
(2, None, 2)
(-1, 'default2', 3)
(0, 'default1', 3)
(3, None, 3)
(4, None, 4)
(5, 'default2', 4)
*/