-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (-1, NULL), (0, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, 0, NULL, -1, -1), (2, -1, 0, NULL, NULL), (-1, -1, 0, -1, -1), (1, NULL, NULL, NULL, 0), (3, -1, NULL, 0, NULL), (4, -1, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 9)
(0, None, 7)
*/

-- Prediction Query
SELECT DISTINCT T1.PLAYER_ID, T2.PLAYER_NAME, COUNT(T1.PLAYER_ID) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN FROM CHAMPIONSHIPS) AS T1 JOIN PLAYERS AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID GROUP BY T1.PLAYER_ID ORDER BY GRAND_SLAMS_COUNT ASC, T1.PLAYER_ID NULLS LAST, T2.PLAYER_NAME NULLS LAST;

/*
Prediction Result:
(0, None, 7)
(-1, None, 9)
*/