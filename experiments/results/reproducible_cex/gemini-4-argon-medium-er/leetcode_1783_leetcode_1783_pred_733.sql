-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (1, 'Alice');
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2020, 1, 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'Alice', 3)
*/

-- Prediction Query
SELECT WINNER AS PLAYER_ID, PLAYER_NAME, COUNT(WINNER) AS GRAND_SLAMS_COUNT FROM (SELECT SUBQ.YEAR, SUBQ.WINNER, PLAYERS.PLAYER_NAME AS PLAYER_NAME FROM (SELECT YEAR, WIMBLEDON AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, FR_OPEN AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, US_OPEN AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, AU_OPEN AS WINNER FROM CHAMPIONSHIPS) AS SUBQ LEFT JOIN PLAYERS ON SUBQ.WINNER = PLAYERS.PLAYER_ID) AS SUBQ2 GROUP BY PLAYER_ID ORDER BY GRAND_SLAMS_COUNT DESC, PLAYER_ID NULLS LAST, PLAYER_NAME NULLS LAST;

/*
Prediction Result:
(1, 'Alice', 3)
(None, None, 0)
*/