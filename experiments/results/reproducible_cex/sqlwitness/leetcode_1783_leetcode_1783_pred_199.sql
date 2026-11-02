-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default2'), (0, 'default1'), (1, 'default2'), (-1, 'default2'), (3, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, NULL, -1, 2, 3), (0, 3, 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 1)
(0, 'default1', 1)
(1, 'default2', 1)
(2, 'default2', 1)
(3, 'default2', 2)
*/

-- Prediction Query
SELECT P2.PLAYER_ID, P1.PLAYER_NAME, P2.NUM AS GRAND_SLAMS_COUNT FROM PLAYERS AS P1 JOIN (SELECT B.PLAYER_ID, COUNT(*) AS NUM FROM (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS) AS B GROUP BY 1) AS P2 ON P1.PLAYER_ID = P2.PLAYER_ID ORDER BY 1 DESC, P1.player_id NULLS LAST;

/*
Prediction Result:
(3, 'default2', 2)
(2, 'default2', 1)
(1, 'default2', 1)
(0, 'default1', 1)
(-1, 'default2', 1)
*/