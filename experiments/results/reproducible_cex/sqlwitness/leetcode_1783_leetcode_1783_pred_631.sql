-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO players (player_id, player_name) VALUES (2, 'US_OPEN');
INSERT INTO championships (year, wimbledon, fr_open, us_open, au_open) VALUES (0, NULL, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(2, 'US_OPEN', 1)
*/

-- Prediction Query
WITH NEW_TABLE AS (SELECT YEAR, 'WIMBLEDON' AS MATHC, WIMBLEDON AS PLAYER_ID FROM CHAMPIONSHIPS UNION SELECT YEAR, 'FR_OPEN' AS MATHC, FR_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION SELECT YEAR, 'US_OPEN' AS MATHC, US_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS UNION SELECT YEAR, 'AU_OPEN' AS MATHC, AU_OPEN AS PLAYER_ID FROM CHAMPIONSHIPS) SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_ID) AS GRAND_SLAMS_COUNT FROM NEW_TABLE LEFT JOIN PLAYERS USING (PLAYER_ID) GROUP BY PLAYER_ID;

/*
Prediction Result:
(None, None, 0)
(2, 'US_OPEN', 1)
*/