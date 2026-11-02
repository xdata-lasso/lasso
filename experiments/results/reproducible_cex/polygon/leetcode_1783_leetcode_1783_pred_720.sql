-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (25, NULL);
INSERT INTO "Players" ("player_id", "player_name") VALUES (24, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (39, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH X AS (SELECT YEAR, 'WIMBLEDON' AS TITLE, WIMBLEDON AS PLAYER FROM CHAMPIONSHIPS UNION SELECT YEAR, 'FR_OPEN' AS TITLE, FR_OPEN AS PLAYER FROM CHAMPIONSHIPS UNION SELECT YEAR, 'US_OPEN' AS TITLE, US_OPEN AS PLAYER FROM CHAMPIONSHIPS UNION SELECT YEAR, 'AU_OPEN' AS TITLE, AU_OPEN AS PLAYER FROM CHAMPIONSHIPS) SELECT P.PLAYER_ID, PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM X LEFT JOIN PLAYERS AS P ON X.PLAYER = P.PLAYER_ID WHERE NOT PLAYER_ID IS NULL GROUP BY 1, 2;

/*
Prediction Result:
*/