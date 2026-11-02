-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (3, 'default2'), (0, 'default2'), (1, 'default1'), (-1, 'default2'), (2, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, NULL, 1, 0, NULL), (3, 2, 0, 2, 3), (-1, 0, 2, 0, -1), (0, 1, NULL, 1, 3), (1, 1, 0, -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 2)
(0, 'default2', 5)
(1, 'default1', 4)
(2, 'default2', 3)
(3, 'default2', 2)
*/

-- Prediction Query
SELECT TMP.PLAYER_ID, PLAYER_NAME, SUM(NUM) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER_ID, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY WIMBLEDON UNION ALL SELECT FR_OPEN AS PLAYER_ID, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY FR_OPEN UNION ALL SELECT US_OPEN AS PLAYER_ID, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY US_OPEN UNION ALL SELECT AU_OPEN AS PLAYER_ID, COUNT(*) AS NUM FROM CHAMPIONSHIPS GROUP BY AU_OPEN) AS TMP LEFT JOIN PLAYERS AS P ON TMP.PLAYER_ID = P.PLAYER_ID GROUP BY 1, 2;

/*
Prediction Result:
(None, None, 4)
(-1, 'default2', 2)
(0, 'default2', 5)
(1, 'default1', 4)
(2, 'default2', 3)
(3, 'default2', 2)
*/