-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, NULL), (0, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, NULL, 0, 0, 0), (2, 2, 0, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default2', 5)
(2, None, 2)
*/

-- Prediction Query
WITH TEMPTBL AS (SELECT WIMBLEDON AS GRANDSLAM FROM CHAMPIONSHIPS AS C1 UNION ALL SELECT FR_OPEN AS GRANDSLAM FROM CHAMPIONSHIPS AS C2 UNION ALL SELECT US_OPEN AS GRANDSLAM FROM CHAMPIONSHIPS AS C3 UNION ALL SELECT AU_OPEN AS GRANDSLAM FROM CHAMPIONSHIPS AS C4) SELECT GRANDSLAM AS PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM TEMPTBL AS T JOIN PLAYERS AS P ON T.GRANDSLAM = P.PLAYER_ID GROUP BY 1 ORDER BY GRAND_SLAMS_COUNT, PLAYER_ID NULLS LAST, P.PLAYER_NAME NULLS LAST;

/*
Prediction Result:
(2, None, 2)
(0, 'default2', 5)
*/