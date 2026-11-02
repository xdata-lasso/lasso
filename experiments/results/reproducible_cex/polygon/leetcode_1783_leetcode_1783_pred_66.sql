-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (33, '39');
INSERT INTO "Players" ("player_id", "player_name") VALUES (32, '40');
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (34, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(TOTAL) AS GRAND_SLAMS_COUNT FROM (SELECT PLAYER_ID, PLAYER_NAME, COUNT(WIMBLEDON) AS TOTAL FROM PLAYERS CROSS JOIN CHAMPIONSHIPS WHERE PLAYER_ID = WIMBLEDON GROUP BY PLAYER_ID UNION ALL SELECT PLAYER_ID, PLAYER_NAME, COUNT(FR_OPEN) AS TOTAL FROM PLAYERS CROSS JOIN CHAMPIONSHIPS WHERE PLAYER_ID = FR_OPEN GROUP BY PLAYER_ID UNION ALL SELECT PLAYER_ID, PLAYER_NAME, COUNT(US_OPEN) AS TOTAL FROM PLAYERS CROSS JOIN CHAMPIONSHIPS WHERE PLAYER_ID = US_OPEN GROUP BY PLAYER_ID UNION ALL SELECT PLAYER_ID, PLAYER_NAME, COUNT(AU_OPEN) AS TOTAL FROM PLAYERS CROSS JOIN CHAMPIONSHIPS WHERE PLAYER_ID = AU_OPEN GROUP BY PLAYER_ID) AS T GROUP BY PLAYER_ID;

/*
Prediction Result:
*/