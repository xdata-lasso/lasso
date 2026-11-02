-- Schema DDL
CREATE TABLE "club" ("Club_ID" INTEGER PRIMARY KEY, "name" TEXT, "Region" TEXT, "Start_year" TEXT);

CREATE TABLE "club_rank" ("Rank" REAL, "Club_ID" INTEGER, "Gold" REAL, "Silver" REAL, "Bronze" REAL, "Total" REAL, PRIMARY KEY ("Rank", "Club_ID"), FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "player" ("Player_ID" INTEGER PRIMARY KEY, "Club_ID" INTEGER, "name" TEXT, "Position" TEXT, "Apps" REAL, "Tries" REAL, "Goals" TEXT, "Points" REAL, FOREIGN KEY ("Club_ID") REFERENCES "club" ("Club_ID"));

CREATE TABLE "competition" ("Competition_ID" INTEGER PRIMARY KEY, "Year" REAL, "Competition_type" TEXT, "Country" TEXT);

CREATE TABLE "competition_result" ("Competition_ID" INTEGER, "Club_ID_1" INTEGER, "Club_ID_2" INTEGER, "Score" TEXT, PRIMARY KEY ("Competition_ID", "Club_ID_1", "Club_ID_2"), FOREIGN KEY ("Competition_ID") REFERENCES "competition" ("Competition_ID"), FOREIGN KEY ("Club_ID_2") REFERENCES "club" ("Club_ID"), FOREIGN KEY ("Club_ID_1") REFERENCES "club" ("Club_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: competition --
INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483648, 582.588439, 'com_f05403', '5k5swwqcgsk');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483647, 572.766956, 'com_f05403', '8c4p');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483646, 935.695299, 'com_f05403', 'u7vfe4hria2y');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (2, 797.015047, 'com_f05403', 'uzhs');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (3, 663.049759, 'com_f05403', 'wbbp6luhvdlt');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483645, 304.02808, 'com_f05403', 'bnp');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483642, 787.938887, 'G', 'dpos');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483641, 133.007885, 'G', '5u');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483640, 933.422701, 'A', '6klfa9');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483639, 877.276439, 'O', '00t5c4ecigc');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483638, 623.093099, 'O', '76nium52');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483637, 816.814398, 'A', 'buo4nrq');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483636, 597.420508, 'E', 'fqyp');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483635, 488.977171, 'E', '5bbp0');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483634, 673.065986, '!', 'eutliqa11r');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483633, 997.73177, 'G', 'ytoo3o9hl7');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483632, 443.457804, 'G', 'lex');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483631, 913.303855, 'A', 'ji7zwau2');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483630, 920.013763, NULL, 'dwyrq13pyu78');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483629, 49.538289, NULL, 'rljsl0b4y');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483628, 598.741024, NULL, '5qi2');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483627, 272.94048, 'com_f05403', '9v');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483626, 263.638479, 'com_f05403', 'x58pz0f8jeg');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (-2147483625, 712.084197, 'com_f05403', '1vy9uxj4');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (5, 582.588439, 'com_54531c', '5k5swwqcgsk');

INSERT INTO "competition" ("competition_id", "year", "competition_type", "country") VALUES (4, 572.766956, 'com_54531c', '8c4p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT competition_type FROM (SELECT competition_type, YEAR, MAX(n) AS n FROM (SELECT competition_id, YEAR, competition_type, country, competition_id_other, competition_id AS n FROM (SELECT LHS.competition_id AS competition_id, LHS.year AS YEAR, LHS.competition_type AS competition_type, LHS.country AS country, RHS.competition_id AS competition_id_other FROM competition AS LHS INNER JOIN (SELECT competition_id, COUNT(*) AS n FROM competition GROUP BY competition_id) AS RHS ON (LHS.competition_id = RHS.n))) GROUP BY competition_type, YEAR) ORDER BY competition_type;

/*
Gold Result:
*/

-- Prediction Query
SELECT Competition_type FROM competition GROUP BY Competition_type ORDER BY COUNT(*) DESC, Competition_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('com_f05403',)
*/