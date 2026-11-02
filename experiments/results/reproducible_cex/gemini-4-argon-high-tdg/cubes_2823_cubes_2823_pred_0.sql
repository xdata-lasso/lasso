-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'Amiodarone', 'Cordarone', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'Phenytoin', 'Dilantin', 'No');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (10, 'UROD', 'Cytosol', 'Coproporphyrinogen III', '1p34', 613521, 'Porphyria cutanea tarda');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (20, 'ALAD', 'Cytosol', 'Porphobilinogen', '9q33.1', 125270, 'ALA dehydratase deficiency');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (5, 'HMBS', 'Cytosol', 'Hydroxymethylbilane', '11q23.3', 609806, 'Acute intermittent porphyria');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (15, 'ALAD', 'Mitochondria', 'Protoporphyrin IX', '15q21.1', 176200, 'Variegate porphyria');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (10, 1, 'inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (10, 2, 'inducer');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (20, 1, 'substrate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('ALAD',)
('ALAD',)
('HMBS',)
('UROD',)
*/

-- Prediction Query
SELECT name FROM enzyme ORDER BY name DESC, enzyme.id NULLS LAST;

/*
Prediction Result:
('UROD',)
('HMBS',)
('ALAD',)
('ALAD',)
*/