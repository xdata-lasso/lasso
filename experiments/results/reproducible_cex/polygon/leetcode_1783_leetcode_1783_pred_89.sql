-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (11, NULL);
INSERT INTO "Players" ("player_id", "player_name") VALUES (10, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (12, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.PLAYER_ID, A.PLAYER_NAME, (SUM(CASE WHEN A.PLAYER_ID = B.WIMBLEDON THEN 1 ELSE 0 END) + SUM(CASE WHEN A.PLAYER_ID = B.FR_OPEN THEN 1 ELSE 0 END) + SUM(CASE WHEN A.PLAYER_ID = B.US_OPEN THEN 1 ELSE 0 END) + SUM(CASE WHEN A.PLAYER_ID = B.AU_OPEN THEN 1 ELSE 0 END)) AS GRAND_SLAMS_COUNT FROM PLAYERS AS A JOIN CHAMPIONSHIPS AS B ON A.PLAYER_ID = B.AU_OPEN OR A.PLAYER_ID = B.WIMBLEDON OR A.PLAYER_ID = B.FR_OPEN OR A.PLAYER_ID = B.US_OPEN GROUP BY 1, 2;

/*
Prediction Result:
*/