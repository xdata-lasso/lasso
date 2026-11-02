-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1004, 'Christopher Bernard', '1559 Roman Stream
Herrerafurt, CO 72858', 'finally', 'themselves', 1005, 'production');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1007, 'Brian Ramirez', '55341 Amanda Gardens Apt. 764
Lake Mark, WI 07832', 'drop', 'term', 1008, 'almost');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1006, 'Shannon Ray', 'Amber Perez', 'figure');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1009, 'Jennifer Jones', 'Latoya Robbins', 'difference');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1004, 1006, 'base');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1007, 1009, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT interaction_type, n AS count___ FROM (SELECT LHS.interaction_type AS interaction_type, LHS.n AS n, RHS.n AS n_other FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type)) AS RHS) WHERE (n = n_other) ORDER BY interaction_type, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('base', 1)
*/

-- Prediction Query
SELECT interaction_type, COUNT(*) FROM medicine_enzyme_interaction GROUP BY interaction_type ORDER BY COUNT(*) DESC, interaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('base', 1)
*/