-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default1'), (-1, 'default1'), (2, NULL), (0, 'default1'), (3, NULL);
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, -1, 2, 2, 3), (-1, 3, 3, NULL, 1), (2, 3, NULL, -1, 1), (1, 3, 1, -1, NULL), (3, 1, 0, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, 'default1', 3)
(0, 'default1', 1)
(1, 'default1', 5)
(2, None, 3)
(3, None, 5)
*/

-- Prediction Query
WITH T AS (SELECT A.PLAYER_ID, A.PLAYER_NAME, ((SELECT COUNT(B.WIMBLEDON) FROM CHAMPIONSHIPS AS B WHERE B.WIMBLEDON = A.PLAYER_ID) + (SELECT COUNT(B.FR_OPEN) FROM CHAMPIONSHIPS AS B WHERE B.FR_OPEN = A.PLAYER_ID) + (SELECT COUNT(B.US_OPEN) FROM CHAMPIONSHIPS AS B WHERE B.US_OPEN = A.PLAYER_ID) + (SELECT COUNT(B.AU_OPEN) FROM CHAMPIONSHIPS AS B WHERE B.AU_OPEN = A.PLAYER_ID)) AS GRAND_SLAMS_COUNT FROM PLAYERS AS A) SELECT * FROM T WHERE T.GRAND_SLAMS_COUNT <> 0 ORDER BY GRAND_SLAMS_COUNT DESC;

/*
Prediction Result:
(1, 'default1', 5)
(3, None, 5)
(-1, 'default1', 3)
(2, None, 3)
(0, 'default1', 1)
*/