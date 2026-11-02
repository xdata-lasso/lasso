-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, NULL), (3, NULL), (1, NULL), (0, NULL), (-1, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 0, 3, 0, 0), (0, 3, 0, 3, 2), (3, 2, 3, -1, 2), (1, -1, 1, 1, 3), (2, NULL, -1, 0, 0), (4, -1, -1, -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 6)
(0, None, 7)
(1, None, 2)
(2, None, 3)
(3, None, 5)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_ID) AS NUM_TOURNAMENT FROM PLAYERS AS P INNER JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON GROUP BY 1, 2 UNION ALL SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_ID) AS NUM_TOURNAMENT FROM PLAYERS AS P INNER JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.FR_OPEN GROUP BY 1, 2 UNION ALL SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_ID) AS NUM_TOURNAMENT FROM PLAYERS AS P INNER JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.US_OPEN GROUP BY 1, 2 UNION ALL SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_ID) AS NUM_TOURNAMENT FROM PLAYERS AS P INNER JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.AU_OPEN GROUP BY 1, 2) SELECT PLAYER_ID, PLAYER_NAME, SUM(NUM_TOURNAMENT) AS GRAND_SLAMS_COUNT FROM TEMP GROUP BY 1, 2 ORDER BY GRAND_SLAMS_COUNT, PLAYER_ID NULLS LAST, PLAYER_NAME NULLS LAST;

/*
Prediction Result:
(1, None, 2)
(2, None, 3)
(3, None, 5)
(-1, None, 6)
(0, None, 7)
*/