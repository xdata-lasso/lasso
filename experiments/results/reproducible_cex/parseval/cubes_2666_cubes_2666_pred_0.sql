-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: competition --
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483648, 582.588439, 'Friendly', 'com_36a547');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483647, 680.190136, 'k5swwqcg', 'com_873059');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (2, 292.730571, 'Friendly', 'com_36a547');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (3, 572.766956, 'Friendly', 'com_36a547');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483646, 206.939346, '8c4pgu7vfe', 'com_873059');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483643, 483.665643, 'hria2ypuzhs', 'com_173fc6');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483642, 663.049759, 'Friendly', 'com_36a547');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483641, 711.020062, 'Friendly', 'com_a4c947');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483640, 944.247544, 'com_240fdb', 'com_36a547');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483639, 994.117864, 'p6luhvdlttil', 'com_873059');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483638, 22.535764, 'Friendly', NULL);

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483637, 600.048938, 'rmdp', NULL);

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (4, 227.766936, NULL, 'iie5u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM (SELECT * FROM "competition" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "competition" WHERE ("competition_type" = 'Friendly')) AS RHS WHERE (LHS.country = RHS.country AND LHS.year = RHS.year))) ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
(None,)
('com_173fc6',)
('com_36a547',)
('com_873059',)
('iie5u',)
*/

-- Prediction Query
SELECT country FROM competition EXCEPT SELECT country FROM competition WHERE competition_type = 'Friendly';

/*
Prediction Result:
('com_173fc6',)
('com_873059',)
('iie5u',)
*/