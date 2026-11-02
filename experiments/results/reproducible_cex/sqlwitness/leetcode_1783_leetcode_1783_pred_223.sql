-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default2'), (2, NULL), (0, NULL), (1, 'default1'), (3, 'default2'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, NULL), (8, NULL), (9, 'default2'), (10, 'default2'), (11, 'default1'), (12, 'default2'), (13, NULL), (14, 'default1'), (15, 'default1'), (16, NULL), (17, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 15, 1, 3, 14), (2, 14, NULL, NULL, 5), (-1, 17, 8, 15, 5), (1, 1, -1, 13, 7), (3, 16, 11, 9, 13), (4, NULL, -1, 0, 2), (5, 13, 13, 4, 8), (6, 17, 14, NULL, 8), (7, -1, -1, 2, 11), (8, -1, 12, 9, -1), (9, 7, 7, 14, 10), (10, 3, 12, 4, 8), (11, 2, 3, 13, 10), (12, 4, 9, 11, NULL), (13, 2, 10, 4, 7), (14, 17, NULL, 16, 16), (15, 6, 17, 12, 3), (16, 12, 3, 14, 2), (17, NULL, 6, 17, 9), (18, 8, 3, 5, 2), (19, 5, NULL, 17, 2), (20, 6, 1, 14, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default2', 7)
(0, None, 1)
(1, 'default1', 3)
(2, None, 7)
(3, 'default2', 6)
(4, 'default1', 4)
(5, 'default1', 4)
(6, None, 3)
(7, None, 4)
(8, None, 5)
(9, 'default2', 4)
(10, 'default2', 3)
(11, 'default1', 3)
(12, 'default2', 4)
(13, None, 5)
(14, 'default1', 6)
(15, 'default1', 2)
(16, None, 3)
(17, 'default2', 6)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(WIMBLEDON = PLAYER_ID) + SUM(FR_OPEN = PLAYER_ID) + SUM(US_OPEN = PLAYER_ID) + SUM(AU_OPEN = PLAYER_ID) AS GRAND_SLAMS_COUNT FROM CHAMPIONSHIPS AS C JOIN PLAYERS AS P ON C.WIMBLEDON = P.PLAYER_ID OR C.FR_OPEN = P.PLAYER_ID OR C.US_OPEN = P.PLAYER_ID OR C.AU_OPEN = P.PLAYER_ID GROUP BY PLAYER_ID;

/*
Prediction Result:
(-1, 'default2', 7)
(0, None, None)
(1, 'default1', 3)
(2, None, 7)
(3, 'default2', 6)
(4, 'default1', 4)
(5, 'default1', 4)
(6, None, 3)
(7, None, 4)
(8, None, 5)
(9, 'default2', 4)
(10, 'default2', 3)
(11, 'default1', 3)
(12, 'default2', 4)
(13, None, 5)
(14, 'default1', 6)
(15, 'default1', 2)
(16, None, 3)
(17, 'default2', 6)
*/