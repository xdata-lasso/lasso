-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT A.YEAR, A.WIMBLEDON FROM CHAMPIONSHIPS AS A UNION ALL SELECT B.YEAR, B.FR_OPEN FROM CHAMPIONSHIPS AS B UNION ALL SELECT C.YEAR, C.US_OPEN FROM CHAMPIONSHIPS AS C UNION ALL SELECT D.YEAR, D.AU_OPEN FROM CHAMPIONSHIPS AS D) SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(*) AS GRAND_SLAMS_COUNT FROM CTE AS C INNER JOIN PLAYERS AS P ON P.PLAYER_ID = C.WIMBLEDON GROUP BY P.PLAYER_ID ORDER BY PLAYER_ID DESC, P.PLAYER_ID NULLS LAST, P.PLAYER_NAME NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
*/