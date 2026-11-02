-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default1'), (0, 'default1'), (-1, NULL), (1, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (-1, -1, NULL, 0, 0), (2, -1, NULL, NULL, 2), (0, 0, 0, -1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 3)
(0, 'default1', 4)
(1, 'default1', 1)
(2, 'default1', 1)
*/

-- Prediction Query
SELECT PA.PLAYER_ID, PA.PLAYER_NAME, A.GRAND_SLAMS_COUNT FROM (SELECT P.PLAYER_ID, SUM(IIF(C.WIMBLEDON = P.PLAYER_ID, 1, 0) + IIF(C.FR_OPEN = P.PLAYER_ID, 1, 0) + IIF(C.US_OPEN = P.PLAYER_ID, 1, 0) + IIF(C.AU_OPEN = P.PLAYER_ID, 1, 0)) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P CROSS JOIN CHAMPIONSHIPS AS C GROUP BY P.PLAYER_ID) AS A JOIN PLAYERS AS PA ON A.PLAYER_ID = PA.PLAYER_ID WHERE GRAND_SLAMS_COUNT <> 0 ORDER BY GRAND_SLAMS_COUNT, PA.player_id NULLS LAST;

/*
Prediction Result:
(1, 'default1', 1)
(2, 'default1', 1)
(-1, None, 3)
(0, 'default1', 4)
*/