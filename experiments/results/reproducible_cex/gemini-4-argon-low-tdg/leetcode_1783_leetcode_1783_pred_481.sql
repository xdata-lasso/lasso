-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests NULL values in tournament columns and empty Championships vs populated Players.
INSERT INTO "Players" ("player_id", "player_name") VALUES (1, 'PartialYearWinner');
INSERT INTO "Players" ("player_id", "player_name") VALUES (2, 'NoWinPlayer');
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2020, 1, NULL, NULL, NULL);
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2021, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'PartialYearWinner', 1)
*/

-- Prediction Query
WITH CTE AS (SELECT YEAR, WIMBLEDON AS GAMES FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, FR_OPEN AS GAMES FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, US_OPEN AS GAMES FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, AU_OPEN AS GAMES FROM CHAMPIONSHIPS ORDER BY YEAR ASC, GAMES NULLS LAST) SELECT PLAYER_ID, PLAYER_NAME, COUNT(GAMES) AS GRAND_SLAMS_COUNT FROM CTE LEFT JOIN PLAYERS ON PLAYERS.PLAYER_ID = CTE.GAMES GROUP BY 1, 2;

/*
Prediction Result:
(None, None, 0)
(1, 'PartialYearWinner', 1)
*/