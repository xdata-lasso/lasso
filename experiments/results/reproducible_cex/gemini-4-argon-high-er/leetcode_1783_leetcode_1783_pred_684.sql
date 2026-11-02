-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Players (player_id, player_name) VALUES (1, 'Alice');
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2020, NULL, 1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'Alice', 3)
*/

-- Prediction Query
WITH WIMBLEDON AS (SELECT DISTINCT WIMBLEDON AS USER_ID, COUNT(YEAR) AS NUM FROM CHAMPIONSHIPS GROUP BY WIMBLEDON), FR_OPEN AS (SELECT DISTINCT FR_OPEN AS USER_ID, COUNT(YEAR) AS NUM FROM CHAMPIONSHIPS GROUP BY FR_OPEN), US_OPEN AS (SELECT DISTINCT US_OPEN AS USER_ID, COUNT(YEAR) AS NUM FROM CHAMPIONSHIPS GROUP BY US_OPEN), AU_OPEN AS (SELECT DISTINCT AU_OPEN AS USER_ID, COUNT(YEAR) AS NUM FROM CHAMPIONSHIPS GROUP BY AU_OPEN), TOTAL AS (SELECT * FROM WIMBLEDON UNION ALL SELECT * FROM FR_OPEN UNION ALL SELECT * FROM US_OPEN UNION ALL SELECT * FROM AU_OPEN) SELECT USER_ID AS PLAYER_ID, PLAYER_NAME, SUM(NUM) AS GRAND_SLAMS_COUNT FROM TOTAL AS T LEFT JOIN PLAYERS AS P ON T.USER_ID = P.PLAYER_ID GROUP BY USER_ID;

/*
Prediction Result:
(None, None, 1)
(1, 'Alice', 3)
*/