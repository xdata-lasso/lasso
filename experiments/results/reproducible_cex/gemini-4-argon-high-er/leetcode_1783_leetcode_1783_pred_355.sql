-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Players (player_id, player_name) VALUES (1, 'Alice');
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2020, 1, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'Alice', 3)
*/

-- Prediction Query
WITH W AS (SELECT WIMBLEDON AS ID, COUNT(1) AS AMOUNT FROM CHAMPIONSHIPS GROUP BY 1), F AS (SELECT FR_OPEN AS ID, COUNT(1) AS AMOUNT FROM CHAMPIONSHIPS GROUP BY 1), U AS (SELECT US_OPEN AS ID, COUNT(1) AS AMOUNT FROM CHAMPIONSHIPS GROUP BY 1), A AS (SELECT AU_OPEN AS ID, COUNT(1) AS AMOUNT FROM CHAMPIONSHIPS GROUP BY 1), ALL1 AS (SELECT * FROM W UNION ALL SELECT * FROM F UNION ALL SELECT * FROM U UNION ALL SELECT * FROM A) SELECT ID AS PLAYER_ID, PLAYERS.PLAYER_NAME, SUM(AMOUNT) AS GRAND_SLAMS_COUNT FROM ALL1 LEFT JOIN PLAYERS ON ALL1.ID = PLAYERS.PLAYER_ID GROUP BY 1, 2;

/*
Prediction Result:
(None, None, 1)
(1, 'Alice', 3)
*/