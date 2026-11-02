-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (18, '24');
INSERT INTO "Players" ("player_id", "player_name") VALUES (17, NULL);
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (19, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT Q1.PLAYER_ID, PL.PLAYER_NAME, SUM(MATCHES) AS GRAND_SLAMS_COUNT FROM (SELECT DISTINCT PLAYER_ID, COUNT(PLAYER_ID) AS MATCHES FROM (SELECT WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN FROM CHAMPIONSHIPS) AS PV GROUP BY 1) AS Q1 JOIN PLAYERS AS PL ON PL.PLAYER_ID = Q1.PLAYER_ID GROUP BY 1, 2;

/*
Prediction Result:
*/