-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'Med1', 'Trade1', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'Med2', 'Trade2', 'No');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'Enz1', 'Loc1', 'Prod1', 'Chr1', 100, 'Por1');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'Enz2', 'Loc2', 'Prod2', 'Chr2', 200, 'Por2');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1, 1, 'inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1, 2, 'inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (2, 2, 'activator');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, fda_approved FROM (SELECT id, name, trade_name, fda_approved, enzyme_id, interaction_type, id AS medicine_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.trade_name AS trade_name, LHS.fda_approved AS fda_approved, RHS.enzyme_id AS enzyme_id, RHS.interaction_type AS interaction_type FROM medicine AS LHS INNER JOIN medicine_enzyme_interaction AS RHS ON (LHS.id = RHS.medicine_id))) ORDER BY id, name NULLS LAST, fda_approved NULLS LAST;

/*
Gold Result:
(1, 'Med1', 'Yes')
(2, 'Med2', 'No')
*/

-- Prediction Query
SELECT T1.id, T1.Name, T1.FDA_approved FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id = T1.id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.id NULLS LAST, T1.Name NULLS LAST, T1.FDA_approved NULLS LAST;

/*
Prediction Result:
(2, 'Med2', 'No')
(1, 'Med1', 'Yes')
*/