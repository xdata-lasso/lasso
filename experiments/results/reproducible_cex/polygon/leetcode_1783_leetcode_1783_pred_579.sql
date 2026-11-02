-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (21, NULL, NULL, NULL, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (20, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.PLAYER_NAME, GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN (SELECT T AS PLAYER_ID, COUNT(T) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS T FROM CHAMPIONSHIPS AS C1 UNION ALL SELECT FR_OPEN AS T FROM CHAMPIONSHIPS AS C2 UNION ALL SELECT US_OPEN AS T FROM CHAMPIONSHIPS AS C3 UNION ALL SELECT AU_OPEN AS T FROM CHAMPIONSHIPS AS C4) AS T GROUP BY T) AS T2 ON T2.PLAYER_ID = P.PLAYER_ID;

/*
Prediction Result:
*/