-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-correlation between id and name, duplicate names (testing DISTINCT/GROUP BY mutants), and orphan vs non-orphan rows (testing erroneous JOINs with interaction table).
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'Med1', 'Trade1', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'Med2', 'Trade2', 'No');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (1, 'Zeta', 'Cytosol', 'ProdZ', '1q', 1001, 'None');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (2, 'Alpha', 'Mitochondria', 'ProdA', '2p', 1002, 'Acute');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (3, 'Alpha', 'Nucleus', 'ProdB', '3q', 1003, 'Cutaneous');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (4, 'Beta', 'Cytosol', 'ProdC', '4p', 1004, 'None');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 1, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 2, 'Inducer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT name FROM enzyme ORDER BY name DESC, enzyme.id NULLS LAST;

/*
Prediction Result:
('Zeta',)
('Beta',)
('Alpha',)
('Alpha',)
*/