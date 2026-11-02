-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "player_name") VALUES (1054, 'Patty Perez');
INSERT INTO "players" ("player_id", "player_name") VALUES (1055, 'Ethan Adams');
INSERT INTO "players" ("player_id", "player_name") VALUES (1056, 'Tommy Walter');
INSERT INTO "players" ("player_id", "player_name") VALUES (1060, 'Matthew Foster');
INSERT INTO "players" ("player_id", "player_name") VALUES (1061, 'Judy Baker');
INSERT INTO "players" ("player_id", "player_name") VALUES (1062, 'Justin Baker');
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1057, 1054, 1054, 1054, 1054);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1058, 1055, 1055, 1055, 1055);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1059, 1056, 1056, 1056, 1056);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1063, 1060, 1060, 1060, NULL);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1064, 1061, 1061, 1061, NULL);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1065, 1062, 1062, 1062, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1054, 'Patty Perez', 4)
(1055, 'Ethan Adams', 4)
(1056, 'Tommy Walter', 4)
(1060, 'Matthew Foster', 3)
(1061, 'Judy Baker', 3)
(1062, 'Justin Baker', 3)
*/

-- Prediction Query
WITH W AS (SELECT YEAR, WIMBLEDON AS W_PLAYER FROM CHAMPIONSHIPS AS C), F AS (SELECT YEAR, FR_OPEN AS F_PLAYER FROM CHAMPIONSHIPS AS C), U AS (SELECT YEAR, US_OPEN AS U_PLAYER FROM CHAMPIONSHIPS AS C), A AS (SELECT YEAR, AU_OPEN AS A_PLAYER FROM CHAMPIONSHIPS AS C) SELECT W_PLAYER AS PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM (SELECT * FROM W UNION ALL SELECT * FROM F UNION ALL SELECT * FROM U UNION ALL SELECT * FROM A) AS T LEFT JOIN PLAYERS AS P ON P.PLAYER_ID = T.W_PLAYER GROUP BY W_PLAYER;

/*
Prediction Result:
(None, None, 3)
(1054, 'Patty Perez', 4)
(1055, 'Ethan Adams', 4)
(1056, 'Tommy Walter', 4)
(1060, 'Matthew Foster', 3)
(1061, 'Judy Baker', 3)
(1062, 'Justin Baker', 3)
*/