-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default1'), (0, 'default1'), (1, 'default1'), (-1, 'default1'), (3, 'default2'), (4, NULL), (5, 'default2'), (6, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 1, 1, 2, 3), (2, 3, 2, 3, 4), (-1, 1, NULL, 6, NULL), (1, NULL, 3, 1, -1), (3, -1, NULL, 5, 2), (4, 0, 6, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 2)
(0, 'default1', 1)
(1, 'default1', 6)
(2, 'default1', 3)
(3, 'default2', 4)
(4, None, 1)
(5, 'default2', 1)
(6, 'default2', 2)
*/

-- Prediction Query
SELECT INR.PLAYER_ID, P.PLAYER_NAME, COUNT(1) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS) AS INR JOIN PLAYERS AS P ON P.PLAYER_ID = INR.PLAYER_ID GROUP BY INR.PLAYER_ID, P.PLAYER_NAME ORDER BY INR.PLAYER_ID DESC, P.PLAYER_NAME NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(6, 'default2', 2)
(5, 'default2', 1)
(4, None, 1)
(3, 'default2', 4)
(2, 'default1', 3)
(1, 'default1', 6)
(0, 'default1', 1)
(-1, 'default1', 2)
*/