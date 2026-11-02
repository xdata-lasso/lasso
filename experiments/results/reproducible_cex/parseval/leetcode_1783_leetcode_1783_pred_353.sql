-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: players --
INSERT INTO "players" ("player_id", "player_name") VALUES (1, 'pla_4a380e');

INSERT INTO "players" ("player_id", "player_name") VALUES (4, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (3, 'A');

INSERT INTO "players" ("player_id", "player_name") VALUES (-2147483645, NULL);

INSERT INTO "players" ("player_id", "player_name") VALUES (2, 'pla_71dfbf');

-- Inserting into table: championships --
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483648, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483647, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483646, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483645, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483644, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483643, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483642, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483641, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483640, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483639, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483638, 3, 3, 4, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483637, -2147483645, 4, 2, -2147483645);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-2147483645, None, 2)
(1, 'pla_4a380e', 40)
(2, 'pla_71dfbf', 1)
(3, 'A', 3)
(4, 'pla_71dfbf', 2)
*/

-- Prediction Query
WITH TEMP_TABLE AS (SELECT WIMBLEDON AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT FR_OPEN AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT US_OPEN AS WINNER FROM CHAMPIONSHIPS UNION ALL SELECT AU_OPEN AS WINNER FROM CHAMPIONSHIPS) SELECT PLAYER_ID, PLAYER_NAME, COUNT(PLAYER_NAME) AS GRAND_SLAMS_COUNT FROM TEMP_TABLE LEFT JOIN PLAYERS ON PLAYER_ID = WINNER GROUP BY PLAYER_ID, PLAYER_NAME;

/*
Prediction Result:
(-2147483645, None, 0)
(1, 'pla_4a380e', 40)
(2, 'pla_71dfbf', 1)
(3, 'A', 3)
(4, 'pla_71dfbf', 2)
*/