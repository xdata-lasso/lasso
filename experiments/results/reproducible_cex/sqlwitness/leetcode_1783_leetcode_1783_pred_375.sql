-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, 'default2'), (1, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 1, 0, 1, 1), (-1, NULL, NULL, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default2', 3)
(1, 'default2', 3)
*/

-- Prediction Query
WITH CTE AS (SELECT WIMBLEDON AS GRANDSLAM FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS GRANDSLAM FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS GRANDSLAM FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS GRANDSLAM FROM CHAMPIONSHIPS) SELECT PLAYER_ID, PLAYER_NAME, TITLE_COUNT AS GRAND_SLAMS_COUNT FROM (SELECT GRANDSLAM, COUNT(*) AS TITLE_COUNT FROM CTE GROUP BY 1) AS X LEFT JOIN PLAYERS AS P ON X.GRANDSLAM = P.PLAYER_ID;

/*
Prediction Result:
(None, None, 2)
(0, 'default2', 3)
(1, 'default2', 3)
*/