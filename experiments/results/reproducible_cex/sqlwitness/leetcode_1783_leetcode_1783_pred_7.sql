-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default1'), (0, 'default1'), (2, 'default1'), (1, 'default2'), (3, 'default2'), (4, NULL), (5, 'default2'), (6, NULL), (7, NULL), (8, 'default2'), (9, 'default2'), (10, 'default2'), (11, 'default2'), (12, 'default2'), (13, 'default2'), (14, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, 14, 8, 4, 1), (0, 14, NULL, 11, 8), (1, 1, 6, 5, 5), (-1, 1, 9, 13, 3), (3, 2, 13, 4, -1), (4, 0, 14, 4, -1), (5, 14, -1, 1, 10), (6, 1, 8, 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 3)
(0, 'default1', 1)
(1, 'default2', 6)
(2, 'default1', 1)
(3, 'default2', 1)
(4, None, 3)
(5, 'default2', 2)
(6, None, 2)
(8, 'default2', 3)
(9, 'default2', 1)
(10, 'default2', 1)
(11, 'default2', 1)
(13, 'default2', 2)
(14, 'default1', 4)
*/

-- Prediction Query
SELECT A.PLAYER_ID, A.PLAYER_NAME, SUM(A.PLAYER_ID = B.WIMBLEDON) + SUM(A.PLAYER_ID = B.FR_OPEN) + SUM(A.PLAYER_ID = B.US_OPEN) + SUM(A.PLAYER_ID = B.AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS A JOIN CHAMPIONSHIPS AS B ON A.PLAYER_ID = B.WIMBLEDON OR A.PLAYER_ID = B.FR_OPEN OR A.PLAYER_ID = B.US_OPEN OR A.PLAYER_ID = B.AU_OPEN GROUP BY A.PLAYER_ID;

/*
Prediction Result:
(-1, 'default1', 3)
(0, 'default1', 1)
(1, 'default2', 6)
(2, 'default1', 1)
(3, 'default2', 1)
(4, None, 3)
(5, 'default2', 2)
(6, None, 2)
(8, 'default2', 3)
(9, 'default2', 1)
(10, 'default2', 1)
(11, 'default2', None)
(13, 'default2', 2)
(14, 'default1', 4)
*/