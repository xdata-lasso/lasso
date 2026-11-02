-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (17, '18');
INSERT INTO "Players" ("player_id", "player_name") VALUES (16, '18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT TB2.WINNER AS PLAYER_ID, P.PLAYER_NAME, TB2.NUM AS GRAND_SLAMS_COUNT FROM (SELECT WINNER, COUNT(WINNER) AS NUM FROM (SELECT WIMBLEDON AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN FROM CHAMPIONSHIPS) AS TB GROUP BY 1) AS TB2 JOIN PLAYERS AS P ON TB2.WINNER = P.PLAYER_ID;

/*
Prediction Result:
*/