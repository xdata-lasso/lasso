-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, NULL), (-1, NULL), (0, 'default2'), (2, 'default2'), (3, 'default2'), (4, 'default2'), (5, NULL), (6, NULL), (7, 'default1'), (8, NULL), (9, NULL), (10, NULL), (11, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 2, 10, 1, NULL), (0, 1, 0, 7, -1), (2, -1, 5, 2, 0), (1, 8, 4, 9, NULL), (3, 3, 5, 2, -1), (4, -1, 5, 11, -1), (5, 1, 9, 10, 0), (6, NULL, 1, 7, 0), (7, 8, 10, 0, 1), (8, 2, 8, 3, 9), (9, 8, 10, NULL, 1), (10, 9, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 5)
(0, 'default2', 5)
(1, None, 6)
(2, 'default2', 4)
(3, 'default2', 2)
(4, 'default2', 1)
(5, None, 3)
(7, 'default1', 2)
(8, None, 4)
(9, None, 4)
(10, None, 4)
(11, 'default2', 1)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(PLAYER_ID = WIMBLEDON) + SUM(PLAYER_ID = FR_OPEN) + SUM(PLAYER_ID = US_OPEN) + SUM(PLAYER_ID = AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS JOIN CHAMPIONSHIPS ON PLAYER_ID = WIMBLEDON OR PLAYER_ID = FR_OPEN OR PLAYER_ID = US_OPEN OR PLAYER_ID = AU_OPEN GROUP BY 1 HAVING GRAND_SLAMS_COUNT > 0;

/*
Prediction Result:
(-1, None, 5)
(0, 'default2', 5)
(1, None, 6)
(2, 'default2', 4)
(3, 'default2', 2)
(5, None, 3)
(7, 'default1', 2)
(8, None, 4)
(9, None, 4)
(10, None, 4)
(11, 'default2', 1)
*/