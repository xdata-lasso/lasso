-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "player_name") VALUES (1060, 'Matthew Foster');
INSERT INTO "players" ("player_id", "player_name") VALUES (1061, 'Judy Baker');
INSERT INTO "players" ("player_id", "player_name") VALUES (1062, 'Justin Baker');
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1063, 1060, 1060, 1060, NULL);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1064, 1061, 1061, 1061, NULL);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1065, 1062, 1062, 1062, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1060, 'Matthew Foster', 3)
(1061, 'Judy Baker', 3)
(1062, 'Justin Baker', 3)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM(WIMBLEDON = PLAYER_ID) + SUM(FR_OPEN = PLAYER_ID) + SUM(US_OPEN = PLAYER_ID) + SUM(AU_OPEN = PLAYER_ID) AS GRAND_SLAMS_COUNT FROM PLAYERS CROSS JOIN CHAMPIONSHIPS GROUP BY 1 HAVING GRAND_SLAMS_COUNT > 0;

/*
Prediction Result:
*/