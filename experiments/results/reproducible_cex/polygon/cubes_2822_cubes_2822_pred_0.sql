-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (7, '1', NULL, NULL);
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (6, '1', NULL, '10');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (9, '1', '1', '1', '1', 1, '1');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (8, '1', '1', '1', '1', 1, '1');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (8, 7, '1');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (8, 6, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
(None, 2)
*/