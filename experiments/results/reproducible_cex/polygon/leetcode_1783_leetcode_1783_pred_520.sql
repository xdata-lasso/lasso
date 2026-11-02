-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (17, '23');
INSERT INTO "Players" ("player_id", "player_name") VALUES (16, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (18, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT TBL.PLAYER_ID, P.PLAYER_NAME, SUM(GS_COUNT) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER_ID, COUNT(*) AS GS_COUNT FROM CHAMPIONSHIPS GROUP BY WIMBLEDON UNION ALL SELECT FR_OPEN AS PLAYER_ID, COUNT(*) AS GS_COUNT FROM CHAMPIONSHIPS GROUP BY FR_OPEN UNION ALL SELECT US_OPEN AS PLAYER_ID, COUNT(*) AS GS_COUNT FROM CHAMPIONSHIPS GROUP BY US_OPEN UNION ALL SELECT AU_OPEN AS PLAYER_ID, COUNT(*) AS GS_COUNT FROM CHAMPIONSHIPS GROUP BY AU_OPEN) AS TBL INNER JOIN PLAYERS AS P ON TBL.PLAYER_ID = P.PLAYER_ID GROUP BY TBL.PLAYER_ID, P.PLAYER_NAME;

/*
Prediction Result:
*/