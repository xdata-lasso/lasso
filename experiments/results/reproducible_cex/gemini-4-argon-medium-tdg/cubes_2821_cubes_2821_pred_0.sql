-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'MedA', 'TradeA', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'MedB', 'TradeB', 'No');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (10, 'CYP2D6', 'Endoplasmic reticulum', 'Hydroxylase', '22q13.1', 124030, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'CYP2D6', 'Mitochondria', 'Oxidase', '22q13.2', 124031, 'Acute');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (5, 'ALAD', 'Cytosol', 'Porphobilinogen', '9q34', 125270, 'ALAD porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (8, 'HMBS', 'Cytosol', 'Hydroxymethylbilane', '11q23.3', 609806, 'AIP');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (10, 1, 'Inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (10, 2, 'Substrate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('ALAD', 'Cytosol')
('CYP2D6', 'Mitochondria')
('CYP2D6', 'Endoplasmic reticulum')
('HMBS', 'Cytosol')
*/

-- Prediction Query
SELECT name, LOCATION FROM enzyme;

/*
Prediction Result:
('CYP2D6', 'Mitochondria')
('ALAD', 'Cytosol')
('HMBS', 'Cytosol')
('CYP2D6', 'Endoplasmic reticulum')
*/