-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: competition --
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483648, 582.588439, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483647, 680.190136, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483646, 487.053947, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (2, 486.033807, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (3, 345.329712, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483645, 833.684115, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483642, 261.897639, 'Tournament', 'G');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483641, 97.952323, 'Tournament', 'G');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483640, 171.746906, 'Tournament', 'A');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483639, 557.512061, 'Tournament', 'O');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483638, 868.436572, 'Tournament', 'O');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483637, 537.136345, 'Tournament', 'A');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483636, 38.937207, 'Tournament', 'G');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483635, 249.706432, 'Tournament', 'G');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483634, 99.523333, 'Tournament', 'A');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483633, 314.813297, 'Tournament', 'I');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483632, 328.996339, 'Tournament', 'I');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483631, 906.21648, 'Tournament', 'A');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483630, 483.665643, 'com_34304a', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483629, 818.685402, 'com_afb1f7', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483628, 804.971537, 'com_4e65cc', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483627, 119.752245, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483626, 134.487977, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483625, 941.961117, 'Tournament', 'com_510a34');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483624, 4.751658, 'Tournament', NULL);

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483623, 441.165949, 'Tournament', NULL);

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483622, 797.015047, 'Tournament', NULL);

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (5, 582.588439, 'Tournament', 'com_5163b7');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (4, 680.190136, 'Tournament', 'com_5163b7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM (SELECT "competition_type", "country", COUNT(*) AS "n" FROM "competition" GROUP BY "competition_type", "country") WHERE ("competition_type" = 'Tournament' AND n > 1) ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
(None,)
('A',)
('G',)
('I',)
('O',)
('com_510a34',)
('com_5163b7',)
*/

-- Prediction Query
SELECT country FROM competition WHERE competition_type = 'Tournament' GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('com_510a34',)
*/