-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests duplicate player names with different player_ids (catches GROUP BY player_name vs GROUP BY player_id mutants).
INSERT INTO "Players" ("player_id", "player_name") VALUES (1, 'John Smith');
INSERT INTO "Players" ("player_id", "player_name") VALUES (2, 'John Smith');
INSERT INTO "Players" ("player_id", "player_name") VALUES (3, 'John Smith');
INSERT INTO "Championships" ("year", "Wimbledon", "Fr_open", "US_open", "Au_open") VALUES (2020, 1, 2, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'John Smith', 2)
(2, 'John Smith', 2)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, COUNT(ID) AS GRAND_SLAMS_COUNT FROM PLAYERS JOIN (SELECT YEAR, WIMBLEDON AS ID FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, FR_OPEN AS ID FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, US_OPEN AS ID FROM CHAMPIONSHIPS UNION ALL SELECT YEAR, AU_OPEN AS ID FROM CHAMPIONSHIPS) AS WINS ON PLAYERS.PLAYER_ID = WINS.ID GROUP BY PLAYER_NAME;

/*
Prediction Result:
(1, 'John Smith', 4)
*/