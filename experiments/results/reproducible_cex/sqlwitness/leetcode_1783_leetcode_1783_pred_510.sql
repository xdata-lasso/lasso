-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, 'default2'), (-1, NULL), (1, 'default1'), (2, 'default1'), (3, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 1, NULL, 0, 3), (0, 2, 2, 1, 3), (1, NULL, -1, 1, 3), (2, 2, 3, 2, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 2)
(0, 'default2', 1)
(1, 'default1', 3)
(2, 'default1', 4)
(3, 'default2', 4)
*/

-- Prediction Query
WITH T1 AS (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS) SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM T1 INNER JOIN PLAYERS AS P ON T1.PLAYER_ID = P.PLAYER_ID GROUP BY P.PLAYER_NAME;

/*
Prediction Result:
(-1, None, 2)
(1, 'default1', 7)
(3, 'default2', 5)
*/