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
SELECT * FROM (SELECT ANS.PLAYER_ID, ANS.PLAYER_NAME, (WIMBLEDON + FR_OPEN + US_OPEN + AU_OPEN) AS GRAND_SLAMS_COUNT FROM (SELECT W1.PLAYER_ID, W1.PLAYER_NAME, W1.WIMBLEDON, F1.FR_OPEN, U1.US_OPEN, A1.AU_OPEN FROM (SELECT W.PLAYER_ID, W.PLAYER_NAME, COUNT(W.WIMBLEDON) AS WIMBLEDON FROM (SELECT P.PLAYER_ID, P.PLAYER_NAME, C.YEAR AS WIMBLEDON FROM PLAYERS AS P LEFT JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.WIMBLEDON) AS W GROUP BY W.PLAYER_ID, W.PLAYER_NAME) AS W1 LEFT JOIN (SELECT F.PLAYER_ID, F.PLAYER_NAME, COUNT(F.FR_OPEN) AS FR_OPEN FROM (SELECT P.PLAYER_ID, P.PLAYER_NAME, C.YEAR AS FR_OPEN FROM PLAYERS AS P LEFT JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.FR_OPEN) AS F GROUP BY F.PLAYER_ID, F.PLAYER_NAME) AS F1 ON W1.PLAYER_ID = F1.PLAYER_ID AND W1.PLAYER_NAME = F1.PLAYER_NAME LEFT JOIN (SELECT U.PLAYER_ID, U.PLAYER_NAME, COUNT(U.US_OPEN) AS US_OPEN FROM (SELECT P.PLAYER_ID, P.PLAYER_NAME, C.YEAR AS US_OPEN FROM PLAYERS AS P LEFT JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.US_OPEN) AS U GROUP BY U.PLAYER_ID, U.PLAYER_NAME) AS U1 ON W1.PLAYER_ID = U1.PLAYER_ID AND W1.PLAYER_NAME = U1.PLAYER_NAME LEFT JOIN (SELECT A.PLAYER_ID, A.PLAYER_NAME, COUNT(A.AU_OPEN) AS AU_OPEN FROM (SELECT P.PLAYER_ID, P.PLAYER_NAME, C.YEAR AS AU_OPEN FROM PLAYERS AS P LEFT JOIN CHAMPIONSHIPS AS C ON P.PLAYER_ID = C.AU_OPEN) AS A GROUP BY A.PLAYER_ID, A.PLAYER_NAME) AS A1 ON W1.PLAYER_ID = A1.PLAYER_ID AND W1.PLAYER_NAME = A1.PLAYER_NAME) AS ANS) AS ANS1 WHERE ANS1.GRAND_SLAMS_COUNT > 0;

/*
Prediction Result:
(1013, 'Daniel Wagner', 4)
(1014, 'Daniel Wagner', 4)
*/