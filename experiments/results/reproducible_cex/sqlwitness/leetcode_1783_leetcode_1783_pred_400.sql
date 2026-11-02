-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default1'), (0, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, 0, 0, 1, NULL), (0, 0, NULL, NULL, NULL), (1, 1, 1, 1, 1), (-1, 1, 1, 1, NULL), (3, 0, NULL, 0, NULL), (4, 1, NULL, 0, NULL), (5, NULL, 0, 1, NULL), (6, 0, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, 'default1', 8)
(1, 'default1', 11)
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.PLAYER_NAME, SUM(PLAYER_ID = WIMBLEDON) + SUM(PLAYER_ID = FR_OPEN) + SUM(PLAYER_ID = US_OPEN) + SUM(PLAYER_ID = AU_OPEN) AS GRAND_SLAMS_COUNT FROM CHAMPIONSHIPS AS C JOIN PLAYERS AS P ON P.PLAYER_ID = C.WIMBLEDON OR P.PLAYER_ID = C.FR_OPEN OR P.PLAYER_ID = C.US_OPEN OR P.PLAYER_ID = C.AU_OPEN GROUP BY P.PLAYER_ID;

/*
Prediction Result:
(0, 'default1', None)
(1, 'default1', 11)
*/