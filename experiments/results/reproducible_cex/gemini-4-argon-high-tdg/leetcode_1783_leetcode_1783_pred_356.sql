-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Players (player_id, player_name) VALUES (10, 'Alex');
INSERT INTO Players (player_id, player_name) VALUES (20, 'Alex');
INSERT INTO Players (player_id, player_name) VALUES (30, 'Alex');
INSERT INTO Players (player_id, player_name) VALUES (40, NULL);
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2015, 10, 10, 20, 40);
INSERT INTO Championships (year, Wimbledon, Fr_open, US_open, Au_open) VALUES (2016, 40, 10, 40, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(10, 'Alex', 4)
(20, 'Alex', 1)
(40, None, 3)
*/

-- Prediction Query
WITH W AS (SELECT YEAR, WIMBLEDON AS ID FROM CHAMPIONSHIPS), F AS (SELECT YEAR, FR_OPEN AS ID FROM CHAMPIONSHIPS), U AS (SELECT YEAR, US_OPEN AS ID FROM CHAMPIONSHIPS), A AS (SELECT YEAR, AU_OPEN AS ID FROM CHAMPIONSHIPS) SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(C.ID) AS GRAND_SLAMS_COUNT FROM (SELECT * FROM W UNION ALL SELECT * FROM F UNION ALL SELECT * FROM U UNION ALL SELECT * FROM A) AS C LEFT JOIN PLAYERS AS P ON C.ID = P.PLAYER_ID GROUP BY P.PLAYER_NAME ORDER BY P.PLAYER_NAME, P.PLAYER_ID NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(40, None, 3)
(10, 'Alex', 5)
*/