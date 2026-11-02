-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enzyme (id, name, location, product, chromosome, omim, porphyria) VALUES (1, NULL, 'default1', 'default2', 'default1', 0, 'default1'), (0, NULL, 'default2', NULL, 'default2', 0, NULL), (2, NULL, 'default1', NULL, 'default1', NULL, NULL), (3, NULL, 'default1', 'default1', NULL, 0, 'default1'), (4, 'default2', 'default2', 'default1', 'default1', 1, NULL), (5, 'default1', 'default2', 'default1', 'default2', 0, 'default2');
INSERT INTO medicine (id, name, trade_name, fda_approved) VALUES (0, NULL, 'default2', 'default1'), (1, NULL, 'default2', 'default2'), (2, 'default1', NULL, NULL), (3, 'default1', 'default1', NULL), (4, NULL, NULL, 'default2'), (5, 'default2', 'default1', 'default2'), (6, NULL, 'default2', 'default2'), (7, 'default2', 'default2', 'default1');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (4, 3, 'default1'), (1, 3, 'default1'), (4, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, fda_approved FROM (SELECT id, name, trade_name, fda_approved, enzyme_id, interaction_type, id AS medicine_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.trade_name AS trade_name, LHS.fda_approved AS fda_approved, RHS.enzyme_id AS enzyme_id, RHS.interaction_type AS interaction_type FROM medicine AS LHS INNER JOIN medicine_enzyme_interaction AS RHS ON (LHS.id = RHS.medicine_id))) ORDER BY id, name NULLS LAST, fda_approved NULLS LAST;

/*
Gold Result:
(0, None, 'default1')
(3, 'default1', None)
*/

-- Prediction Query
SELECT T1.id, T1.Name, T1.FDA_approved FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id = T1.id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.id NULLS LAST, T1.Name NULLS LAST, T1.FDA_approved NULLS LAST;

/*
Prediction Result:
(3, 'default1', None)
(0, None, 'default1')
*/