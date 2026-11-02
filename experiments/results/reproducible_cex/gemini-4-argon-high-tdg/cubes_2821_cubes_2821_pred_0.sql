-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'Amisulpride', 'Solian', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'Clozapine', 'Clozaril', 'Yes');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (30, 'Uroporphyrinogen III synthase', 'Cytoplasm', 'Uroporphyrinogen III', '10q25.2-q26.3', 606938, 'Congenital erythropoietic porphyria');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (10, 'ALA synthase', 'Mitochondria', 'Delta-aminolevulinic acid', '3p21.1', 125290, 'None');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (20, 'ALA synthase', 'Cytosol', 'Delta-aminolevulinic acid', 'Xp11.21', 301300, 'X-linked sideroblastic anemia');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (5, 'Ferrochelatase', 'Mitochondria', 'Heme', '18q21.3', 177000, 'Erythropoietic protoporphyria');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (15, 'Ferrochelatase', 'Mitochondria', 'Protoheme', '18q21.3', 177000, 'Erythropoietic protoporphyria');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (25, 'Coproporphyrinogen oxidase', 'Intermembrane space', 'Protoporphyrinogen IX', '3q12', 121300, 'Hereditary coproporphyria');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (40, 'Coproporphyrinogen oxidase', 'Mitochondrial matrix', 'Protoporphyrinogen IX', '3q12', 121300, 'Hereditary coproporphyria');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (10, 1, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (10, 2, 'Inducer');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (30, 2, 'Substrate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('ALA synthase', 'Mitochondria')
('ALA synthase', 'Cytosol')
('Coproporphyrinogen oxidase', 'Intermembrane space')
('Coproporphyrinogen oxidase', 'Mitochondrial matrix')
('Ferrochelatase', 'Mitochondria')
('Ferrochelatase', 'Mitochondria')
('Uroporphyrinogen III synthase', 'Cytoplasm')
*/

-- Prediction Query
SELECT name, LOCATION FROM enzyme;

/*
Prediction Result:
('Ferrochelatase', 'Mitochondria')
('ALA synthase', 'Mitochondria')
('Ferrochelatase', 'Mitochondria')
('ALA synthase', 'Cytosol')
('Coproporphyrinogen oxidase', 'Intermembrane space')
('Uroporphyrinogen III synthase', 'Cytoplasm')
('Coproporphyrinogen oxidase', 'Mitochondrial matrix')
*/