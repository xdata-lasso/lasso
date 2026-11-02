-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (8, 'AlphaMed', 'AlphaTrade', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (5, 'BetaMed', 'BetaTrade', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'GammaMed', 'GammaTrade', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'DeltaMed', 'DeltaTrade', 'Yes');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (1, 'UROD', 'Cytosol', 'Coproporphyrinogen III', '1p34.1', 613521, 'PCT');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (2, 'CPOX', 'Mitochondria', 'Protoporphyrinogen IX', '3q12.1', 612732, 'HCP');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (3, 'PPOX', 'Mitochondria', 'Protoporphyrin IX', '1q23.3', 600923, 'VP');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 5, 'activator');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (2, 5, 'activator');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (3, 5, 'activator');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 2, 'inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (2, 2, 'activator');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (3, 8, 'competitive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, fda_approved FROM (SELECT id, name, trade_name, fda_approved, enzyme_id, interaction_type, id AS medicine_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.trade_name AS trade_name, LHS.fda_approved AS fda_approved, RHS.enzyme_id AS enzyme_id, RHS.interaction_type AS interaction_type FROM medicine AS LHS INNER JOIN medicine_enzyme_interaction AS RHS ON (LHS.id = RHS.medicine_id))) ORDER BY id, name NULLS LAST, fda_approved NULLS LAST;

/*
Gold Result:
(2, 'GammaMed', 'No')
(5, 'BetaMed', 'Yes')
(8, 'AlphaMed', 'No')
*/

-- Prediction Query
SELECT T1.id, T1.Name, T1.FDA_approved FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id = T1.id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.id NULLS LAST, T1.Name NULLS LAST, T1.FDA_approved NULLS LAST;

/*
Prediction Result:
(5, 'BetaMed', 'Yes')
(2, 'GammaMed', 'No')
(8, 'AlphaMed', 'No')
*/