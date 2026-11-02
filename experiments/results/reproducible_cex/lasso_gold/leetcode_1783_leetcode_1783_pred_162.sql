-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "player_name") VALUES (1035, 'Monica Herrera');
INSERT INTO "players" ("player_id", "player_name") VALUES (1037, 'Jamie Arnold');
INSERT INTO "players" ("player_id", "player_name") VALUES (0, NULL);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1036, 1035, 1035, 1035, 1035);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1038, 1037, 1037, 1037, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(0, None, 1)
(1035, 'Monica Herrera', 4)
(1037, 'Jamie Arnold', 3)
*/

-- Prediction Query
SELECT A.PLAYER_ID, A.PLAYER_NAME, TRUNC(A.GRAND_SLAMS_COUNT) AS GRAND_SLAMS_COUNT FROM (SELECT P.PLAYER_ID, P.PLAYER_NAME, CAST(SUM(CASE WHEN C.WIMBLEDON = P.PLAYER_ID THEN C.WIMBLEDON ELSE 0 END) AS REAL) / P.PLAYER_ID + CAST(SUM(CASE WHEN C.FR_OPEN = P.PLAYER_ID THEN C.FR_OPEN ELSE 0 END) AS REAL) / P.PLAYER_ID + CAST(SUM(CASE WHEN C.US_OPEN = P.PLAYER_ID THEN C.US_OPEN ELSE 0 END) AS REAL) / P.PLAYER_ID + CAST(SUM(CASE WHEN C.AU_OPEN = P.PLAYER_ID THEN C.AU_OPEN ELSE 0 END) AS REAL) / P.PLAYER_ID AS GRAND_SLAMS_COUNT FROM PLAYERS AS P CROSS JOIN CHAMPIONSHIPS AS C GROUP BY P.PLAYER_ID, P.PLAYER_NAME) AS A WHERE A.GRAND_SLAMS_COUNT > 0;

/*
Prediction Result:
(1035, 'Monica Herrera', 4.0)
(1037, 'Jamie Arnold', 3.0)
*/