-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (17, '16');
INSERT INTO "Players" ("player_id", "player_name") VALUES (16, '16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT WIMBLEDON AS ID, COUNT(WIMBLEDON) AS CT FROM CHAMPIONSHIPS GROUP BY 1 UNION ALL SELECT FR_OPEN AS ID, COUNT(FR_OPEN) AS CT FROM CHAMPIONSHIPS GROUP BY 1 UNION ALL SELECT US_OPEN AS ID, COUNT(US_OPEN) AS CT FROM CHAMPIONSHIPS GROUP BY 1 UNION ALL SELECT AU_OPEN AS ID, COUNT(AU_OPEN) AS CT FROM CHAMPIONSHIPS GROUP BY 1) SELECT ID AS PLAYER_ID, PLAYER_NAME, SUM(CT) AS GRAND_SLAMS_COUNT FROM CTE JOIN PLAYERS AS P ON P.PLAYER_ID = ID GROUP BY 1;

/*
Prediction Result:
*/