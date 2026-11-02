-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default2'), (2, 'default1'), (3, 'default2'), (0, 'default1'), (1, 'default2'), (4, 'default2'), (5, 'default2'), (6, 'default2'), (7, NULL), (8, NULL), (9, 'default2'), (10, 'default1'), (11, 'default1'), (12, NULL), (13, 'default1'), (14, 'default2'), (15, 'default2'), (16, NULL), (17, 'default1'), (18, NULL), (19, 'default2'), (20, NULL), (21, 'default2'), (22, 'default2'), (23, NULL), (24, 'default2'), (25, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 3, 3, 24, 11), (-1, 13, 2, 24, 12), (1, 6, 0, 16, 22), (3, 24, 9, 2, 15), (2, NULL, 25, 17, 23), (4, 11, 22, 2, 11), (5, 18, 11, 4, 9), (6, -1, 23, 2, 21), (7, 3, 13, 2, 23), (8, 8, 10, 17, 11), (9, 16, 18, 10, 4), (10, 8, NULL, 1, 14), (11, 0, 13, 12, 19), (12, 18, 16, 2, -1), (13, 22, 22, 13, 2), (14, 1, NULL, 5, 6), (15, 2, 16, 18, 25), (16, 3, -1, 16, 6), (17, 0, 13, 25, 24), (18, 12, 3, 8, 6), (19, 2, 4, 13, 25), (20, 7, 6, 19, 24), (21, 9, 4, 10, 6), (22, 22, 12, 0, 12), (23, 1, 4, 7, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 3)
(0, 'default1', 4)
(1, 'default2', 3)
(2, 'default1', 9)
(3, 'default2', 5)
(4, 'default2', 5)
(5, 'default2', 1)
(6, 'default2', 6)
(7, None, 2)
(8, None, 3)
(9, 'default2', 3)
(10, 'default1', 3)
(11, 'default1', 5)
(12, None, 5)
(13, 'default1', 6)
(14, 'default2', 1)
(15, 'default2', 1)
(16, None, 5)
(17, 'default1', 2)
(18, None, 4)
(19, 'default2', 2)
(21, 'default2', 1)
(22, 'default2', 5)
(23, None, 3)
(24, 'default2', 5)
(25, 'default1', 5)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(PLAYER_ID = WIMBLEDON) + SUM(PLAYER_ID = FR_OPEN) + SUM(PLAYER_ID = US_OPEN) + SUM(PLAYER_ID = AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS JOIN CHAMPIONSHIPS ON PLAYER_ID = WIMBLEDON OR PLAYER_ID = FR_OPEN OR PLAYER_ID = US_OPEN OR PLAYER_ID = AU_OPEN GROUP BY 1, 2;

/*
Prediction Result:
(-1, 'default2', 3)
(0, 'default1', 4)
(1, 'default2', 3)
(2, 'default1', 9)
(3, 'default2', 5)
(4, 'default2', 5)
(5, 'default2', None)
(6, 'default2', 6)
(7, None, 2)
(8, None, 3)
(9, 'default2', 3)
(10, 'default1', 3)
(11, 'default1', 5)
(12, None, 5)
(13, 'default1', 6)
(14, 'default2', None)
(15, 'default2', 1)
(16, None, 5)
(17, 'default1', 2)
(18, None, 4)
(19, 'default2', 2)
(21, 'default2', 1)
(22, 'default2', 5)
(23, None, 3)
(24, 'default2', 5)
(25, 'default1', 5)
*/