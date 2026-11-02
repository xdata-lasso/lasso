-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default2'), (1, 'default2'), (-1, NULL), (0, 'default2'), (3, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (1, 3, 1, -1, 1), (2, 0, 0, 3, -1), (0, NULL, 0, 1, 3), (-1, -1, 2, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 3)
(0, 'default2', 4)
(1, 'default2', 4)
(2, 'default2', 1)
(3, 'default2', 3)
*/

-- Prediction Query
SELECT B.PLAYER AS PLAYER_ID, P.PLAYER_NAME, B.GRAND_SLAMS_COUNT FROM (SELECT A.PLAYER, COUNT(A.PLAYER) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER FROM CHAMPIONSHIPS) AS A GROUP BY A.PLAYER) AS B LEFT JOIN PLAYERS AS P ON B.PLAYER = P.PLAYER_ID;

/*
Prediction Result:
(None, None, 0)
(-1, None, 3)
(0, 'default2', 4)
(1, 'default2', 4)
(2, 'default2', 1)
(3, 'default2', 3)
*/