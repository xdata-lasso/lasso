-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, NULL), (-1, 'default1'), (2, 'default2'), (1, NULL), (3, 'default2'), (4, 'default2'), (5, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, 1, 2, 0, 3), (-1, 3, 3, 3, -1), (0, 3, 4, 4, 2), (1, 1, 2, 0, -1), (3, 4, 1, 1, -1), (4, 3, -1, 5, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 4)
(0, None, 2)
(1, None, 4)
(2, 'default2', 4)
(3, 'default2', 6)
(4, 'default2', 3)
(5, 'default1', 1)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(PLAYER_ID = WIMBLEDON) + SUM(PLAYER_ID = FR_OPEN) + SUM(PLAYER_ID = US_OPEN) + SUM(PLAYER_ID = AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P INNER JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON OR P.PLAYER_ID = C.FR_OPEN OR P.PLAYER_ID = C.US_OPEN OR P.PLAYER_ID = C.AU_OPEN GROUP BY PLAYER_ID ORDER BY GRAND_SLAMS_COUNT ASC, PLAYER_ID NULLS LAST, PLAYER_NAME NULLS LAST;

/*
Prediction Result:
(5, 'default1', 1)
(0, None, 2)
(4, 'default2', 3)
(-1, 'default1', 4)
(1, None, 4)
(2, 'default2', 4)
(3, 'default2', 6)
*/