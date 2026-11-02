-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (19, 'US_OPEN30');
INSERT INTO "Players" ("player_id", "player_name") VALUES (18, 'AU_OPEN31');
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
WITH CTE AS (SELECT DISTINCT CHAMPION, COUNT(GAME) AS GRAND_SLAMS_COUNT FROM (SELECT YEAR, 'WIMBLEDON' AS GAME, WIMBLEDON AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'FR_OPEN' AS GAME, FR_OPEN AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'US_OPEN' AS GAME, US_OPEN AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'AU_OPEN' AS GAME, AU_OPEN AS CHAMPION FROM CHAMPIONSHIPS) AS A GROUP BY CHAMPION) SELECT CTE.CHAMPION AS PLAYER_ID, P.PLAYER_NAME, CTE.GRAND_SLAMS_COUNT FROM CTE JOIN PLAYERS AS P ON CTE.CHAMPION = P.PLAYER_ID;

/*
Prediction Result:
*/