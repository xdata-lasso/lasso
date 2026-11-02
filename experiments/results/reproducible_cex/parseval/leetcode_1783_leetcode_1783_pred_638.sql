-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: players --
INSERT INTO "players" ("player_id", "player_name") VALUES (1, 'p_s_324513');

INSERT INTO "players" ("player_id", "player_name") VALUES (3, 'p_s_324513');

INSERT INTO "players" ("player_id", "player_name") VALUES (4, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (5, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (2, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (6, 'pla_71dfbf');

-- Inserting into table: championships --
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483648, 4, 5, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483647, 2, 5, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483646, 5, 4, 1, 4);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483645, 4, 1, 4, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483644, 1, 1, 4, 3);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483643, 5, 6, 4, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483642, 2, 2, 3, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483641, 2, 2, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483640, 5, 2, 3, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483639, 2, 6, 4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'p_s_324513', 9)
(2, 'pla_71dfbf', 12)
(3, 'p_s_324513', 4)
(4, 'pla_71dfbf', 8)
(5, 'pla_71dfbf', 5)
(6, 'pla_71dfbf', 2)
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.PLAYER_NAME, SUM(P.PLAYER_ID = C.WIMBLEDON) + SUM(P.PLAYER_ID = C.FR_OPEN) + SUM(P.PLAYER_ID = C.US_OPEN) + SUM(P.PLAYER_ID = C.AU_OPEN) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON (P.PLAYER_ID = C.WIMBLEDON OR P.PLAYER_ID = C.FR_OPEN OR P.PLAYER_ID = C.US_OPEN OR P.PLAYER_ID = C.AU_OPEN) GROUP BY P.PLAYER_NAME;

/*
Prediction Result:
(1, 'p_s_324513', 13)
(2, 'pla_71dfbf', 27)
*/