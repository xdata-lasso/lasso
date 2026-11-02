-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (4, NULL), (-1, 'default2'), (0, NULL), (3, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 4, 4, 3, NULL), (4, 3, 0, -1, 3), (-1, 3, 3, 0, -1), (1, -1, NULL, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 3)
(0, None, 3)
(3, 'default1', 5)
(4, None, 2)
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.PLAYER_NAME, SUM(CASE WHEN P.PLAYER_ID = C.WIMBLEDON THEN 1 ELSE 0 END) + SUM(CASE WHEN P.PLAYER_ID = C.FR_OPEN THEN 1 ELSE 0 END) + SUM(CASE WHEN P.PLAYER_ID = C.US_OPEN THEN 1 ELSE 0 END) + SUM(CASE WHEN P.PLAYER_ID = C.AU_OPEN THEN 1 ELSE 0 END) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON OR P.PLAYER_ID = C.FR_OPEN OR P.PLAYER_ID = C.US_OPEN OR P.PLAYER_ID = C.AU_OPEN GROUP BY 1, 2 ORDER BY 3, P.PLAYER_ID NULLS LAST, P.PLAYER_NAME NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(4, None, 2)
(-1, 'default2', 3)
(0, None, 3)
(3, 'default1', 5)
*/