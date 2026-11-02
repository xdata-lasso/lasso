-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, 'default1'), (1, 'default1'), (2, 'default1'), (-1, 'default2'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, NULL), (8, 'default2'), (9, 'default1'), (10, 'default2'), (11, NULL), (12, NULL), (13, NULL), (14, 'default1'), (15, NULL), (16, 'default1'), (17, 'default2'), (18, 'default2'), (19, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 18, 10, 13, 3), (1, 14, 4, 6, 15), (2, 11, 7, 5, 0), (0, 11, 15, NULL, 17), (3, NULL, 16, 6, 3), (4, 15, 2, NULL, 1), (5, 11, 19, 0, 18), (6, 3, 6, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default1', 2)
(1, 'default1', 1)
(2, 'default1', 1)
(3, 'default2', 4)
(4, 'default2', 1)
(5, None, 1)
(6, None, 3)
(7, None, 1)
(10, 'default2', 1)
(11, None, 3)
(13, None, 1)
(14, 'default1', 1)
(15, None, 3)
(16, 'default1', 1)
(17, 'default2', 1)
(18, 'default2', 2)
(19, None, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT P.PLAYER_ID, SUM(P.PLAYER_ID = WIMBLEDON) + SUM(P.PLAYER_ID = FR_OPEN) + SUM(P.PLAYER_ID = US_OPEN) + SUM(P.PLAYER_ID = AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON (P.PLAYER_ID = WIMBLEDON OR P.PLAYER_ID = FR_OPEN OR P.PLAYER_ID = US_OPEN OR P.PLAYER_ID = AU_OPEN) GROUP BY PLAYER_ID) SELECT P.PLAYER_ID, P.PLAYER_NAME, GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CTE ON P.PLAYER_ID = CTE.PLAYER_ID;

/*
Prediction Result:
(0, 'default1', 2)
(1, 'default1', None)
(2, 'default1', None)
(3, 'default2', 4)
(4, 'default2', 1)
(5, None, 1)
(6, None, 3)
(7, None, 1)
(10, 'default2', 1)
(11, None, 3)
(13, None, 1)
(14, 'default1', 1)
(15, None, 3)
(16, 'default1', None)
(17, 'default2', None)
(18, 'default2', 2)
(19, None, 1)
*/