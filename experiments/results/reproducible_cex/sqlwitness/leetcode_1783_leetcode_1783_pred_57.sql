-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (0, NULL), (1, 'default1'), (-1, 'default1'), (2, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (1, NULL, 1, 1, 2), (2, 0, -1, 0, 1), (0, -1, -1, 1, -1), (-1, 0, NULL, 1, NULL), (3, 1, NULL, 2, -1), (4, -1, 1, NULL, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 7)
(0, None, 3)
(1, 'default1', 7)
(2, 'default1', 2)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(GRAND_SLAMS_COUNT) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON GROUP BY P.PLAYER_ID UNION SELECT FR_OPEN AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.FR_OPEN GROUP BY P.PLAYER_ID UNION SELECT US_OPEN AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.US_OPEN GROUP BY P.PLAYER_ID UNION SELECT AU_OPEN AS CHAMPIONSHIP, P.PLAYER_ID, P.PLAYER_NAME, COUNT(P.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.AU_OPEN GROUP BY P.PLAYER_ID) AS A GROUP BY PLAYER_ID;

/*
Prediction Result:
(-1, 'default1', 5)
(0, None, 3)
(1, 'default1', 6)
(2, 'default1', 1)
*/