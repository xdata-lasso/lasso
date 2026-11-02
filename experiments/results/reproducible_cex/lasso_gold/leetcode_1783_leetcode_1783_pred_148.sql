-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "player_name") VALUES (1054, 'Patty Perez');
INSERT INTO "players" ("player_id", "player_name") VALUES (1055, 'Ethan Adams');
INSERT INTO "players" ("player_id", "player_name") VALUES (1056, 'Tommy Walter');
INSERT INTO "players" ("player_id", "player_name") VALUES (1086, 'Sherri Baker');
INSERT INTO "players" ("player_id", "player_name") VALUES (1087, 'Cassandra Gaines');
INSERT INTO "players" ("player_id", "player_name") VALUES (1088, 'Elizabeth Fowler');
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1057, 1054, 1054, 1054, 1054);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1058, 1055, 1055, 1055, 1055);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1059, 1056, 1056, 1056, 1056);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1089, NULL, 1086, 1086, 1086);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1090, NULL, 1087, 1087, 1087);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1091, NULL, 1088, 1088, 1088);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1054, 'Patty Perez', 4)
(1055, 'Ethan Adams', 4)
(1056, 'Tommy Walter', 4)
(1086, 'Sherri Baker', 3)
(1087, 'Cassandra Gaines', 3)
(1088, 'Elizabeth Fowler', 3)
*/

-- Prediction Query
SELECT A.PLAYER_ID, A.PLAYER_NAME, SUM(A.SLAM_COUNT) AS GRAND_SLAMS_COUNT FROM (SELECT A.PLAYER_ID, A.PLAYER_NAME, COUNT(WIMBLEDON) AS SLAM_COUNT, 'WIMBLEDON' AS EVENT_TYPE FROM PLAYERS AS A CROSS JOIN CHAMPIONSHIPS AS B WHERE (A.PLAYER_ID = B.WIMBLEDON) GROUP BY A.PLAYER_ID, A.PLAYER_NAME UNION SELECT A.PLAYER_ID, A.PLAYER_NAME, COUNT(FR_OPEN) AS SLAM_COUNT, 'FRENCH OPEN' AS EVENT_TYPE FROM PLAYERS AS A CROSS JOIN CHAMPIONSHIPS AS B WHERE (A.PLAYER_ID = B.FR_OPEN) GROUP BY A.PLAYER_ID, A.PLAYER_NAME UNION SELECT A.PLAYER_ID, A.PLAYER_NAME, COUNT(WIMBLEDON) AS SLAM_COUNT, 'US OPEN' AS EVENT_TYPE FROM PLAYERS AS A CROSS JOIN CHAMPIONSHIPS AS B WHERE (A.PLAYER_ID = B.US_OPEN) GROUP BY A.PLAYER_ID, A.PLAYER_NAME UNION SELECT A.PLAYER_ID, A.PLAYER_NAME, COUNT(FR_OPEN) AS SLAM_COUNT, 'AU OPEN' AS EVENT_TYPE FROM PLAYERS AS A CROSS JOIN CHAMPIONSHIPS AS B WHERE (A.PLAYER_ID = B.AU_OPEN) GROUP BY A.PLAYER_ID, A.PLAYER_NAME) AS A GROUP BY A.PLAYER_ID, A.PLAYER_NAME;

/*
Prediction Result:
(1054, 'Patty Perez', 4)
(1055, 'Ethan Adams', 4)
(1056, 'Tommy Walter', 4)
(1086, 'Sherri Baker', 2)
(1087, 'Cassandra Gaines', 2)
(1088, 'Elizabeth Fowler', 2)
*/