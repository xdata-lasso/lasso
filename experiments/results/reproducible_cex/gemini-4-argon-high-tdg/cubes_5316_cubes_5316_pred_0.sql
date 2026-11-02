-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'Fluconazole', 'Diflucan', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'Ketoconazole', 'Nizoral', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (3, 'Rifampin', 'Rifadin', 'Yes');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (1, 'CYP2D6', 'Endoplasmic reticulum', 'Monooxygenase', '22q13.2', 124030, 'None');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (2, 'CYP2C19', 'Microsome', 'Hydroxylase', '10q23.33', 124020, 'None');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (3, 'CYP2E1', 'Endoplasmic reticulum', 'Oxidase', '10q26.3', 124040, 'None');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 1, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 2, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 3, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (2, 1, 'Metabolizer');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (3, 1, 'Activator');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (3, 2, 'Activator');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (3, 3, 'Activator');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT interaction_type, n AS count___ FROM (SELECT LHS.interaction_type AS interaction_type, LHS.n AS n, RHS.n AS n_other FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type) AS LHS CROSS JOIN (SELECT MAX(n) AS n FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type)) AS RHS) WHERE (n = n_other) ORDER BY interaction_type, count___ NULLS LAST;

/*
Gold Result:
('Activator', 3)
('Inhibitor', 3)
*/

-- Prediction Query
SELECT interaction_type, COUNT(*) FROM medicine_enzyme_interaction GROUP BY interaction_type ORDER BY COUNT(*) DESC, interaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('Activator', 3)
*/