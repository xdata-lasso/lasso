-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: medicine --
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483648, '5k5swwqcgs', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483647, '9n8', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483646, '4', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483645, 'gu7v', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483644, 'e4', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483643, 'hria2ypuzhs', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483642, 'rwbbp6luhvd', NULL, 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483641, 'tti', NULL, 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483640, 'bnp', NULL, 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483639, 'mdpos', 'med_470229', NULL);

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483638, 'ie5', 'med_470229', NULL);

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483637, 'nw6klf', 'med_470229', NULL);

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483636, 'a9000t5c4eci', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483635, 'gce376nium52', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483634, 'zbuo4nrqrof', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483633, 'qyp5s5bbp0', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483632, '2eutliqa11r', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483631, 'ytoo3o9', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483630, 'l7', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483629, 'klex14ji', 'med_470229', 'med_ac1a81');

INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (-2147483628, '7zwau2dwyr', 'med_470229', 'med_ac1a81');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('med_470229', 3)
('med_470229', 15)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
(None, 3)
('med_470229', 18)
*/