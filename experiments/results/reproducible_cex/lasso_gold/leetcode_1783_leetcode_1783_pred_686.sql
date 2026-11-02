-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "players" ("player_id", "player_name") VALUES (1001, 'Allison Hill');
INSERT INTO "players" ("player_id", "player_name") VALUES (1002, 'Noah Rhodes');
INSERT INTO "players" ("player_id", "player_name") VALUES (1003, 'Angie Henderson');
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1004, 1001, 1001, 1001, 1001);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1005, 1002, 1002, 1002, 1002);
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1006, 1003, 1003, 1003, 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1001, 'Allison Hill', 4)
(1002, 'Noah Rhodes', 4)
(1003, 'Angie Henderson', 4)
*/

-- Prediction Query
SELECT P.PLAYER_NAME, P.PLAYER_ID, C.GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN (SELECT CHAMPION, COUNT(*) AS GRAND_SLAMS_COUNT FROM (SELECT YEAR, 'WIMBLEDON' AS GAME, WIMBLEDON AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'FR_OPEN' AS GAME, FR_OPEN AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'US_OPEN' AS GAME, US_OPEN AS CHAMPION FROM CHAMPIONSHIPS UNION SELECT YEAR, 'AU_OPEN' AS GAME, AU_OPEN AS CHAMPION FROM CHAMPIONSHIPS) AS T GROUP BY CHAMPION) AS C ON P.PLAYER_ID = C.CHAMPION;

/*
Prediction Result:
('Allison Hill', 1001, 4)
('Noah Rhodes', 1002, 4)
('Angie Henderson', 1003, 4)
*/