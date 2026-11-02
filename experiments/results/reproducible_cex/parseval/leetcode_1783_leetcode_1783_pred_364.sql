-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: players --
INSERT INTO "players" ("player_id", "player_name") VALUES (1, 'p_s_85d304');

INSERT INTO "players" ("player_id", "player_name") VALUES (3, 'p_s_bbc3ee');

INSERT INTO "players" ("player_id", "player_name") VALUES (2, 'p_s_bbc3ee');

INSERT INTO "players" ("player_id", "player_name") VALUES (4, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (-2147483644, 'pla_550066');

INSERT INTO "players" ("player_id", "player_name") VALUES (-2147483643, NULL);

INSERT INTO "players" ("player_id", "player_name") VALUES (5, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (-2147483641, NULL);

INSERT INTO "players" ("player_id", "player_name") VALUES (6, 'pla_71dfbf');

-- Inserting into table: championships --
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483648, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (1, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483646, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483645, 1, 1, 1, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483644, 2, 2, 2, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483643, 2, 3, 1, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483642, -2147483644, 4, 3, 4);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483641, -2147483644, -2147483643, -2147483643, 5);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483640, -2147483641, 2, -2147483641, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(-2147483644, 'pla_550066', 2)
(-2147483643, None, 2)
(-2147483641, None, 2)
(1, 'p_s_85d304', 17)
(2, 'p_s_bbc3ee', 6)
(3, 'p_s_bbc3ee', 3)
(4, 'pla_71dfbf', 2)
(5, 'pla_71dfbf', 1)
(6, 'pla_71dfbf', 1)
*/

-- Prediction Query
WITH W AS (SELECT YEAR, WIMBLEDON AS ID FROM CHAMPIONSHIPS), F AS (SELECT YEAR, FR_OPEN AS ID FROM CHAMPIONSHIPS), U AS (SELECT YEAR, US_OPEN AS ID FROM CHAMPIONSHIPS), A AS (SELECT YEAR, AU_OPEN AS ID FROM CHAMPIONSHIPS) SELECT P.PLAYER_ID, P.PLAYER_NAME, COUNT(C.ID) AS GRAND_SLAMS_COUNT FROM (SELECT * FROM W UNION ALL SELECT * FROM F UNION ALL SELECT * FROM U UNION ALL SELECT * FROM A) AS C LEFT JOIN PLAYERS AS P ON C.ID = P.PLAYER_ID GROUP BY P.PLAYER_NAME ORDER BY P.PLAYER_NAME, P.PLAYER_ID NULLS LAST, GRAND_SLAMS_COUNT NULLS LAST;

/*
Prediction Result:
(-2147483641, None, 4)
(1, 'p_s_85d304', 17)
(2, 'p_s_bbc3ee', 9)
(-2147483644, 'pla_550066', 2)
(4, 'pla_71dfbf', 4)
*/