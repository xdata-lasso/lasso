-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY (fda_approved, trade_name), secondary ordering on count___, and column confusion (name vs Trade_Name).
-- Also includes an unreferenced medicine and a multi-enzyme medicine to kill accidental JOINs with medicine_enzyme_interaction.
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'ChemZ', 'BrandA', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'ChemZ', 'BrandA', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (3, 'ChemZ', 'BrandA', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (4, 'ChemA', 'BrandB', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (5, 'ChemB', 'BrandB', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (6, 'ChemC', 'BrandB', 'Yes');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (10, 'Enz1', 'Liver', 'Prod1', '1p', 1001, 'None');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (20, 'Enz2', 'Kidney', 'Prod2', '2q', 1002, 'Acute');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (10, 1, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (20, 1, 'Inducer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
('BrandA', 1)
('BrandA', 2)
('BrandB', 3)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
('BrandA', 3)
('BrandB', 3)
*/