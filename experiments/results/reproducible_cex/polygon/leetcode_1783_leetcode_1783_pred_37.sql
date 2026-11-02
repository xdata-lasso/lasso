-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (10, '16');
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (11, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.PLAYER_NAME, SUM(CASE WHEN C.WIMBLEDON = PLAYER_ID THEN 1 ELSE 0 END) + SUM(CASE WHEN C.FR_OPEN = PLAYER_ID THEN 1 ELSE 0 END) + SUM(CASE WHEN C.US_OPEN = PLAYER_ID THEN 1 ELSE 0 END) + SUM(CASE WHEN C.AU_OPEN = PLAYER_ID THEN 1 ELSE 0 END) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P CROSS JOIN CHAMPIONSHIPS AS C GROUP BY 1 HAVING GRAND_SLAMS_COUNT > 0;

/*
Prediction Result:
*/