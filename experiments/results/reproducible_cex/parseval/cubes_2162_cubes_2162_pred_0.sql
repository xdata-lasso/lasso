-- Schema DDL
CREATE TABLE "architect" ("id" TEXT PRIMARY KEY, "name" TEXT, "nationality" TEXT, "gender" TEXT);

CREATE TABLE "bridge" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "name" TEXT, "location" TEXT, "length_meters" REAL, "length_feet" REAL, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

CREATE TABLE "mill" ("id" INTEGER PRIMARY KEY, "architect_id" INTEGER, "location" TEXT, "name" TEXT, "type" TEXT, "built_year" INTEGER, "notes" TEXT, FOREIGN KEY ("architect_id") REFERENCES "architect" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: architect --
INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_1', '5k5swwqcgs', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_2', '9n8', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_3', '4', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_4', 'gu7v', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_5', 'e4', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_6', 'hria2ypuzhs', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_7', 'rwbbp6luhvd', NULL, 'tti');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_8', 'bnp', NULL, 'mdpos');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_9', 'ie5', NULL, 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_10', 'nw6klf', NULL, 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_11', 'a9000t5c4eci', NULL, 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_12', 'gce376nium52', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_13', 'zbuo4nrqrof', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_14', 'qyp5s5bbp0', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_15', '2eutliqa11r', 'ytoo3o9', NULL);

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_16', 'l7', 'klex14ji', NULL);

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_17', '7zwau2dwyr', 'arc_3cc17b', NULL);

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_18', '13pyu', 'arc_3cc17b', NULL);

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_19', '8d99rljsl', 'arc_3cc17b', NULL);

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_20', 'b4yp5qi', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_21', 'rkf9vqx5', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_22', 'pz0f8jegd', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_23', '1vy9uxj4', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_24', 'wb', 'arc_3cc17b', 'arc_f01e4a');

INSERT INTO "architect" ("id", "name", "nationality", "gender") VALUES ('id_25', 'v', 'arc_3cc17b', 'arc_f01e4a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n_distinct" AS "count___" FROM (SELECT "gender", "nationality", COUNT(DISTINCT "gender") AS "n_distinct" FROM "architect" GROUP BY "gender", "nationality") WHERE ("gender" <> 'female') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM architect WHERE gender = 'female';

/*
Prediction Result:
(0,)
*/