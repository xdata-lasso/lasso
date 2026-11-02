-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests individual tournament columns (missing column in SUM/UNION), multiple wins in the same year vs across years (COUNT vs SUM), and filtering out players with 0 wins (LEFT JOIN vs INNER JOIN).
INSERT INTO "Players" ("player_id", "player_name") VALUES (1, 'Alice');
INSERT INTO "Players" ("player_id", "player_name") VALUES (2, 'Bob');
INSERT INTO "Players" ("player_id", "player_name") VALUES (3, 'Charlie');
INSERT INTO "Players" ("player_id", "player_name") VALUES (4, 'Diana');
INSERT INTO "Players" ("player_id", "player_name") VALUES (5, 'Evan');
INSERT INTO "Players" ("player_id", "player_name") VALUES (6, 'ZeroWins');
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2020, 1, 2, 3, 4);
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2021, 5, 5, 5, 5);
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2022, 1, 2, 5, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'Alice', 2)
(2, 'Bob', 2)
(3, 'Charlie', 1)
(4, 'Diana', 2)
(5, 'Evan', 5)
*/

-- Prediction Query
SELECT P.PLAYER_NAME, P.PLAYER_ID, C.GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN (SELECT CHAMPION, COUNT(*) AS GRAND_SLAMS_COUNT FROM (SELECT YEAR, 'WIMBLEDON' AS GAME, WIMBLEDON AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'FR_OPEN' AS GAME, FR_OPEN AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'US_OPEN' AS GAME, US_OPEN AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'AU_OPEN' AS GAME, AU_OPEN AS CHAMPION FROM CHAMPIONSHIPS) AS T GROUP BY CHAMPION) AS C ON P.PLAYER_ID = C.CHAMPION;

/*
Prediction Result:
('Alice', 1, 2)
('Bob', 2, 2)
('Charlie', 3, 1)
('Diana', 4, 2)
('Evan', 5, 5)
*/