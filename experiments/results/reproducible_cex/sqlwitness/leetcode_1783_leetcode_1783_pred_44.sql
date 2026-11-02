-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default1'), (2, NULL), (1, 'default2'), (0, 'default2'), (3, NULL), (4, 'default2'), (5, 'default2'), (6, NULL), (7, 'default1'), (8, NULL), (9, NULL), (10, 'default1'), (11, 'default2'), (12, 'default1'), (13, 'default1'), (14, 'default1'), (15, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 4, 10, 2, NULL), (0, 8, 7, 15, 5), (1, 3, 4, 12, NULL), (2, 10, 1, 5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default2', 1)
(1, 'default2', 1)
(2, None, 1)
(3, None, 1)
(4, 'default2', 2)
(5, 'default2', 2)
(7, 'default1', 1)
(8, None, 1)
(10, 'default1', 2)
(12, 'default1', 1)
(15, 'default2', 1)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, (SUM(PLAYER_ID = WIMBLEDON) + SUM(PLAYER_ID = FR_OPEN) + SUM(PLAYER_ID = US_OPEN) + SUM(PLAYER_ID = AU_OPEN)) AS GRAND_SLAMS_COUNT FROM PLAYERS JOIN CHAMPIONSHIPS ON PLAYER_ID = WIMBLEDON OR PLAYER_ID = FR_OPEN OR PLAYER_ID = US_OPEN OR PLAYER_ID = AU_OPEN GROUP BY PLAYER_ID;

/*
Prediction Result:
(0, 'default2', 1)
(1, 'default2', 1)
(2, None, None)
(3, None, None)
(4, 'default2', None)
(5, 'default2', 2)
(7, 'default1', 1)
(8, None, 1)
(10, 'default1', 2)
(12, 'default1', None)
(15, 'default2', 1)
*/