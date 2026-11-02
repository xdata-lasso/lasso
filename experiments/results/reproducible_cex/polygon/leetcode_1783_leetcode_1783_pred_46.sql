-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (33, NULL);
INSERT INTO "Players" ("player_id", "player_name") VALUES (34, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (32, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM (SELECT P1.PLAYER_ID, P1.PLAYER_NAME FROM CHAMPIONSHIPS AS C1 JOIN PLAYERS AS P1 ON C1.AU_OPEN = P1.PLAYER_ID UNION ALL SELECT P2.PLAYER_ID, P2.PLAYER_NAME FROM CHAMPIONSHIPS AS C2 JOIN PLAYERS AS P2 ON C2.WIMBLEDON = P2.PLAYER_ID UNION ALL SELECT P3.PLAYER_ID, P3.PLAYER_NAME FROM CHAMPIONSHIPS AS C3 JOIN PLAYERS AS P3 ON C3.FR_OPEN = P3.PLAYER_ID UNION ALL SELECT P4.PLAYER_ID, P4.PLAYER_NAME FROM CHAMPIONSHIPS AS C4 JOIN PLAYERS AS P4 ON C4.US_OPEN = P4.PLAYER_ID) AS ALLWINNERS GROUP BY PLAYER_ID, PLAYER_NAME;

/*
Prediction Result:
*/