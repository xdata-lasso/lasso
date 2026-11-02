-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Players" ("player_id", "player_name") VALUES (26, '33');
INSERT INTO "Championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (27, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(C.WIMBLEDON) AS X1 FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON GROUP BY P.PLAYER_ID, C.YEAR UNION ALL SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(C.FR_OPEN) AS X1 FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.FR_OPEN GROUP BY P.PLAYER_ID, C.YEAR UNION ALL SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(C.US_OPEN) AS X1 FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.US_OPEN GROUP BY P.PLAYER_ID, C.YEAR UNION ALL SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(C.AU_OPEN) AS X1 FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.AU_OPEN GROUP BY P.PLAYER_ID, C.YEAR) SELECT PLAYER_ID, PLAYER_NAME, SUM(X1) AS GRAND_SLAMS_COUNT FROM A WHERE CASE WHEN X1 = 0 THEN 0 ELSE 1 END GROUP BY PLAYER_ID;

/*
Prediction Result:
*/