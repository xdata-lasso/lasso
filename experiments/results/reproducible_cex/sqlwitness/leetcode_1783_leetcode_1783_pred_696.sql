-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default2'), (-1, 'default1'), (0, 'default2'), (2, NULL), (3, 'default1'), (4, NULL), (5, 'default1'), (6, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, NULL, -1, 3, 6), (-1, NULL, 3, 3, -1), (1, 1, 5, NULL, 0), (0, 4, 6, 6, -1), (3, -1, 6, 0, NULL), (4, 2, 6, 5, 2), (5, 3, 0, 2, 1), (6, -1, -1, 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 6)
(0, 'default2', 3)
(1, 'default2', 2)
(2, None, 3)
(3, 'default1', 5)
(4, None, 1)
(5, 'default1', 3)
(6, 'default2', 5)
*/

-- Prediction Query
WITH C AS (SELECT P.PLAYER_ID, COUNT(1) AS CHAM FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON GROUP BY P.PLAYER_ID UNION ALL SELECT P.PLAYER_ID, COUNT(1) AS CHAM FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.FR_OPEN GROUP BY P.PLAYER_ID UNION ALL SELECT P.PLAYER_ID, COUNT(1) AS CHAM FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.US_OPEN GROUP BY P.PLAYER_ID UNION ALL SELECT P.PLAYER_ID, COUNT(1) AS CHAM FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.AU_OPEN GROUP BY P.PLAYER_ID) SELECT C.PLAYER_ID, P.PLAYER_NAME, SUM(C.CHAM) AS GRAND_SLAMS_COUNT FROM C LEFT JOIN PLAYERS AS P ON C.PLAYER_ID = P.PLAYER_ID GROUP BY C.PLAYER_ID HAVING GRAND_SLAMS_COUNT > 0 ORDER BY P.PLAYER_NAME, C.PLAYER_ID NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(2, None, 3)
(4, None, 1)
(-1, 'default1', 6)
(3, 'default1', 5)
(5, 'default1', 3)
(0, 'default2', 3)
(1, 'default2', 2)
(6, 'default2', 5)
*/