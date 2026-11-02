-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (33, '43');
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (42, NULL, NULL, NULL, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (41, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH CHAMPS AS (SELECT YEAR, WIMBLEDON AS CHM, B.PLAYER_NAME, 1 AS SLAMS FROM CHAMPIONSHIPS AS A JOIN PLAYERS AS B ON A.WIMBLEDON = B.PLAYER_ID UNION ALL SELECT YEAR, FR_OPEN AS CHM, B.PLAYER_NAME, 1 AS SLAMS FROM CHAMPIONSHIPS AS A JOIN PLAYERS AS B ON A.FR_OPEN = B.PLAYER_ID UNION ALL SELECT YEAR, US_OPEN AS CHM, B.PLAYER_NAME, 1 AS SLAMS FROM CHAMPIONSHIPS AS A JOIN PLAYERS AS B ON A.US_OPEN = B.PLAYER_ID UNION ALL SELECT YEAR, AU_OPEN AS CHM, B.PLAYER_NAME, 1 AS SLAMS FROM CHAMPIONSHIPS AS A JOIN PLAYERS AS B ON A.AU_OPEN = B.PLAYER_ID) SELECT CHM AS PLAYER_ID, PLAYER_NAME, SUM(SLAMS) AS GRAND_SLAMS_COUNT FROM CHAMPS GROUP BY 1, 2;

/*
Prediction Result:
*/