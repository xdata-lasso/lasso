-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests handling of NULL values in tournament columns and players with NULL names.
INSERT INTO "Players" ("player_id", "player_name") VALUES (1, NULL);
INSERT INTO "Players" ("player_id", "player_name") VALUES (2, 'Boris');
INSERT INTO "Players" ("player_id", "player_name") VALUES (3, 'Clara');
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2015, 1, NULL, NULL, NULL);
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2016, NULL, 2, NULL, 1);
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2017, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, None, 2)
(2, 'Boris', 1)
*/

-- Prediction Query
SELECT PLAYER AS PLAYER_ID, PLAYERS.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM (SELECT WIMBLEDON AS PLAYER FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS PLAYER FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS PLAYER FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS PLAYER FROM CHAMPIONSHIPS) AS A LEFT JOIN PLAYERS ON PLAYERS.PLAYER_ID = A.PLAYER GROUP BY 1;

/*
Prediction Result:
(None, None, 9)
(1, None, 2)
(2, 'Boris', 1)
*/