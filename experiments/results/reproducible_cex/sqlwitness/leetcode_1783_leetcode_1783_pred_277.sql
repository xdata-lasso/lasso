-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (1, 'default1'), (-1, NULL), (0, 'default1'), (2, 'default1');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (2, NULL, 0, NULL, NULL), (-1, 2, -1, NULL, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-1, None, 2)
(0, 'default1', 1)
(2, 'default1', 1)
*/

-- Prediction Query
WITH CTE AS (SELECT YEAR, WIMBLEDON AS TOUR FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, FR_OPEN AS TOUR FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, US_OPEN AS TOUR FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, AU_OPEN AS TOUR FROM CHAMPIONSHIPS) SELECT TOUR AS PLAYER_ID, PLAYER_NAME, COUNT(TOUR) AS GRAND_SLAMS_COUNT FROM CTE LEFT JOIN PLAYERS ON TOUR = PLAYER_ID GROUP BY TOUR;

/*
Prediction Result:
(None, None, 0)
(-1, None, 2)
(0, 'default1', 1)
(2, 'default1', 1)
*/