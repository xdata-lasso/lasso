-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default2'), (2, NULL), (-1, 'default2'), (0, NULL), (3, 'default1'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'default1'), (8, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 6, -1, 0, 2), (2, 4, 0, 5, 2), (1, 6, -1, 1, 6), (0, 5, 3, 2, 6), (3, 2, 4, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 2)
(0, None, 3)
(1, 'default2', 2)
(2, None, 4)
(3, 'default1', 1)
(4, 'default1', 2)
(5, 'default1', 2)
(6, None, 4)
*/

-- Prediction Query
WITH CTE AS (SELECT C.YEAR, P.PLAYER_ID, P.PLAYER_NAME FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.WIMBLEDON UNION ALL SELECT C.YEAR, P.PLAYER_ID, P.PLAYER_NAME FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.FR_OPEN UNION ALL SELECT C.YEAR, P.PLAYER_ID, P.PLAYER_NAME FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.US_OPEN UNION ALL SELECT C.YEAR, P.PLAYER_ID, P.PLAYER_NAME FROM CHAMPIONSHIPS AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.AU_OPEN) SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_ID) AS GRAND_SLAMS_COUNT FROM CTE GROUP BY PLAYER_ID ORDER BY PLAYER_NAME ASC, PLAYER_ID NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(0, None, 3)
(2, None, 4)
(6, None, 4)
(3, 'default1', 1)
(4, 'default1', 2)
(5, 'default1', 2)
(-1, 'default2', 2)
(1, 'default2', 2)
*/