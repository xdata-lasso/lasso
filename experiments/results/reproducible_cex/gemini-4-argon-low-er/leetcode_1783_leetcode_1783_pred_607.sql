-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (1, 'Nadal');
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2020, 1, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'Nadal', 1)
*/

-- Prediction Query
WITH PLAYER_CHAMPIONSHIPS AS (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS), PLAYER_WINS AS (SELECT PLAYER_ID, COUNT(*) AS GRAND_SLAMS_COUNT FROM PLAYER_CHAMPIONSHIPS GROUP BY PLAYER_ID) SELECT PW.PLAYER_ID, P.PLAYER_NAME, PW.GRAND_SLAMS_COUNT FROM PLAYER_WINS AS PW LEFT JOIN PLAYERS AS P ON PW.PLAYER_ID = P.PLAYER_ID;

/*
Prediction Result:
(None, None, 3)
(1, 'Nadal', 1)
*/