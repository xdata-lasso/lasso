-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, 'default1'), (0, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, 0, 0, NULL, NULL), (0, -1, NULL, -1, NULL), (2, NULL, -1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 3)
(0, None, 3)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, PLAYER_NAME, SUM(WIMBLEDON = PLAYER_ID) AS WIM, SUM(FR_OPEN = PLAYER_ID) AS FR, SUM(US_OPEN = PLAYER_ID) AS US, SUM(AU_OPEN = PLAYER_ID) AS AU FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON OR P.PLAYER_ID = C.FR_OPEN OR P.PLAYER_ID = C.US_OPEN OR P.PLAYER_ID = C.AU_OPEN GROUP BY PLAYER_ID) SELECT PLAYER_ID, PLAYER_NAME, WIM + FR + US + AU AS GRAND_SLAMS_COUNT FROM CTE;

/*
Prediction Result:
(-1, 'default1', 3)
(0, None, None)
*/