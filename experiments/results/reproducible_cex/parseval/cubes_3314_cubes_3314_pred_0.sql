-- Schema DDL
CREATE TABLE "body_builder" ("Body_Builder_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Snatch" REAL, "Clean_Jerk" REAL, "Total" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Birth_Date" TEXT, "Birth_Place" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483648, '5k5swwqcgs', 1.0, 171.746906, 'n8c4pgu7v', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483647, 'e4', 1.0, 779.409124, 'hria2ypuzhs', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483646, 'rwbbp6luhvd', 1.0, 179.378884, 'ilbnp', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483645, 'mdpos', 1.0, 133.007885, '5u', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483644, 'w6kl', 1.0, 83.204633, '9', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483643, '00t5c4e', 1.0, 950.466571, 'i', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483642, 'gce376nium52', 1.0, 816.814398, 'buo4nrq', NULL);

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483641, 'rofqyp5s5b', 1.0, 22.720462, '02eu', NULL);

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483640, 'liqa1', 1.0, 982.938576, 'yytoo', NULL);

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483639, 'o9hl72kl', NULL, 74.250383, 'x14ji7zwau2d', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483638, 'yrq13p', NULL, 375.832821, '8d99rljsl', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483637, 'b4yp5qi', NULL, 447.109657, 'f9v', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483636, 'x58pz', 1.0, 410.133844, '8j', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483635, 'gd', 1.0, 452.27611, 'vy9uxj4', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483634, 'wb', 1.0, 50.647649, 'ph2', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483633, 'nd', 1.0, 893.16532, 'wnqcx', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483632, '5hncprjtu0d', 1.0, 395.809081, 'fjgq8n2f3', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483631, 'dqv0gcb98ozk', 1.0, 463.845085, 'i', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483630, 'yrk', 1.0, 615.222139, '6vck', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483629, 'ah0f8jsww', 1.0, 176.824244, 'xb72fxa7r', 'peo_399835');

INSERT INTO "people" ("people_id", "name", "height", "weight", "birth_date", "birth_place") VALUES (-2147483628, 'fdrz16n', 1.0, 130.468488, 'jai', 'peo_399835');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, n AS count___ FROM (SELECT birth_place, height, COUNT(*) AS n FROM people GROUP BY birth_place, height) ORDER BY birth_place, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('peo_399835', 3)
('peo_399835', 15)
*/

-- Prediction Query
SELECT Birth_Place, COUNT(*) FROM people GROUP BY Birth_Place;

/*
Prediction Result:
(None, 3)
('peo_399835', 18)
*/