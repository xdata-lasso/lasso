-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (1, NULL, NULL, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(2, 'default1', 1)
*/

-- Prediction Query
WITH TEMP AS (SELECT ALL_WINS FROM (SELECT C1.WIMBLEDON AS ALL_WINS FROM CHAMPIONSHIPS AS C1 UNION ALL SELECT C2.FR_OPEN FROM CHAMPIONSHIPS AS C2 UNION ALL SELECT C3.US_OPEN FROM CHAMPIONSHIPS AS C3 UNION ALL SELECT C4.AU_OPEN FROM CHAMPIONSHIPS AS C4) AS NEW_TABLE) SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(TEMP.ALL_WINS) AS GRAND_SLAMS_COUNT FROM TEMP LEFT JOIN PLAYERS AS P ON TEMP.ALL_WINS = P.PLAYER_ID GROUP BY TEMP.ALL_WINS;

/*
Prediction Result:
(None, None, 0)
(2, 'default1', 1)
*/