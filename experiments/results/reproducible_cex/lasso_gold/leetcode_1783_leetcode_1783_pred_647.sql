-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "player_name") VALUES (1013, 'Daniel Wagner');
INSERT INTO "players" ("player_id", "player_name") VALUES (1014, 'Daniel Wagner');
INSERT INTO "players" ("player_id", "player_name") VALUES (1008, NULL);
INSERT INTO "players" ("player_id", "player_name") VALUES (1009, NULL);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1010, 1013, 1013, 1013, 1013);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1011, 1008, 1008, 1008, 1008);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1012, 1009, 1009, 1009, 1009);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1015, 1014, 1014, 1014, 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1008, None, 4)
(1009, None, 4)
(1013, 'Daniel Wagner', 4)
(1014, 'Daniel Wagner', 4)
*/

-- Prediction Query
WITH CTE AS (SELECT WIMBLEDON AS WIN FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS WIN FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS WIN FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS WIN FROM CHAMPIONSHIPS) SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM CTE LEFT JOIN PLAYERS AS P ON WIN = P.PLAYER_ID GROUP BY PLAYER_NAME;

/*
Prediction Result:
(1008, None, 8)
(1013, 'Daniel Wagner', 8)
*/