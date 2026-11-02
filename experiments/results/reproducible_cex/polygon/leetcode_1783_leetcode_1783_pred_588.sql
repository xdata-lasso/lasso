-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (17, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (19, NULL, NULL, NULL, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (18, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.PLAYER_ID, P.PLAYER_NAME, B.GRAND_SLAMS_COUNT FROM (SELECT A.PLAYER_ID, SUM(A.GAME_COUNT) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER_ID, COUNT(WIMBLEDON) AS GAME_COUNT FROM CHAMPIONSHIPS GROUP BY WIMBLEDON UNION ALL SELECT FR_OPEN AS PLAYER_ID, COUNT(FR_OPEN) AS GAME_COUNT FROM CHAMPIONSHIPS GROUP BY FR_OPEN UNION ALL SELECT US_OPEN AS PLAYER_ID, COUNT(US_OPEN) AS GAME_COUNT FROM CHAMPIONSHIPS GROUP BY US_OPEN UNION ALL SELECT AU_OPEN AS PLAYER_ID, COUNT(AU_OPEN) AS GAME_COUNT FROM CHAMPIONSHIPS GROUP BY AU_OPEN) AS A GROUP BY A.PLAYER_ID) AS B JOIN PLAYERS AS P ON B.PLAYER_ID = P.PLAYER_ID WHERE B.GRAND_SLAMS_COUNT <> 0;

/*
Prediction Result:
*/