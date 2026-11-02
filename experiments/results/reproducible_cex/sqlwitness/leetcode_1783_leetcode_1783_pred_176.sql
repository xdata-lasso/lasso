-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default1'), (-1, NULL), (2, 'default2'), (0, 'default1'), (3, 'default2');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 0, 1, 3, 0), (0, -1, NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 1)
(0, 'default1', 3)
(1, 'default1', 1)
(3, 'default2', 1)
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.PLAYER_NAME, (SUM(C.WIMBLEDON = P.PLAYER_ID) + SUM(C.FR_OPEN = P.PLAYER_ID) + SUM(C.US_OPEN = P.PLAYER_ID) + SUM(C.AU_OPEN = P.PLAYER_ID)) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P CROSS JOIN CHAMPIONSHIPS AS C WHERE C.WIMBLEDON = P.PLAYER_ID OR C.FR_OPEN = P.PLAYER_ID OR C.US_OPEN = P.PLAYER_ID OR C.AU_OPEN = P.PLAYER_ID GROUP BY P.PLAYER_ID;

/*
Prediction Result:
(-1, None, None)
(0, 'default1', 3)
(1, 'default1', 1)
(3, 'default2', 1)
*/