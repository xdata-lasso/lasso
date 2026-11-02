-- Schema DDL
CREATE TABLE "Players" ("player_id" INTEGER PRIMARY KEY, "player_name" TEXT(255));

CREATE TABLE "Championships" ("year" INTEGER PRIMARY KEY, "Wimbledon" INTEGER, "Fr_open" INTEGER, "US_open" INTEGER, "Au_open" INTEGER, FOREIGN KEY ("Wimbledon") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Fr_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("US_open") REFERENCES "Players" ("player_id"), FOREIGN KEY ("Au_open") REFERENCES "Players" ("player_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: players --
INSERT INTO "players" ("player_id", "player_name") VALUES (1, 'p_s_d493d8');

INSERT INTO "players" ("player_id", "player_name") VALUES (3, 'p_s_d493d8');

INSERT INTO "players" ("player_id", "player_name") VALUES (4, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (5, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (2, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (6, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (7, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (8, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (9, 'pla_71dfbf');

INSERT INTO "players" ("player_id", "player_name") VALUES (10, 'pla_71dfbf');

-- Inserting into table: championships --
INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483648, 4, 5, 2, 1);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (-2147483647, 5, 6, 4, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (2, 5, 7, 6, 7);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (3, 6, 7, 8, 2);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (4, 9, 7, 1, 4);

INSERT INTO "championships" ("year", "wimbledon", "fr_open", "us_open", "au_open") VALUES (5, 3, 10, 10, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT player_id, player_name, SUM((CASE WHEN player_id = wimbledon THEN 1 ELSE 0 END + CASE WHEN player_id = fr_open THEN 1 ELSE 0 END + CASE WHEN player_id = us_open THEN 1 ELSE 0 END + CASE WHEN player_id = au_open THEN 1 ELSE 0 END)) AS grand_slams_count FROM players CROSS JOIN championships GROUP BY player_id) AS z WHERE grand_slams_count > 0;

/*
Gold Result:
(1, 'p_s_d493d8', 2)
(2, 'pla_71dfbf', 3)
(3, 'p_s_d493d8', 1)
(4, 'pla_71dfbf', 3)
(5, 'pla_71dfbf', 3)
(6, 'pla_71dfbf', 4)
(7, 'pla_71dfbf', 4)
(8, 'pla_71dfbf', 1)
(9, 'pla_71dfbf', 1)
(10, 'pla_71dfbf', 2)
*/

-- Prediction Query
SELECT PLAYER_ID, PLAYER_NAME, SUM((CASE WHEN C.WIMBLEDON = P.PLAYER_ID THEN 1 ELSE 0 END) + (CASE WHEN C.FR_OPEN = P.PLAYER_ID THEN 1 ELSE 0 END) + (CASE WHEN C.US_OPEN = P.PLAYER_ID THEN 1 ELSE 0 END) + (CASE WHEN C.AU_OPEN = P.PLAYER_ID THEN 1 ELSE 0 END)) AS GRAND_SLAMS_COUNT FROM PLAYERS AS P JOIN CHAMPIONSHIPS AS C ON PLAYER_ID = FR_OPEN OR PLAYER_ID = US_OPEN OR PLAYER_ID = AU_OPEN OR PLAYER_ID = WIMBLEDON GROUP BY PLAYER_NAME;

/*
Prediction Result:
(1, 'p_s_d493d8', 3)
(2, 'pla_71dfbf', 21)
*/