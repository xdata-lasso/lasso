-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'Hemin', 'Panhematin', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'Givosiran', 'Givlaari', 'Yes');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (10, 'UROD', 'Cytosol', 'Coproporphyrinogen III', '1p34', 176100, 'Porphyria cutanea tarda');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (20, 'ALAD', 'Cytosol', 'Porphobilinogen', '9q34', 125270, 'ALAD deficiency porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (30, 'HMBS', 'Cytosol', 'Hydroxymethylbilane', '11q23.3', 609806, 'Acute intermittent porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (40, 'UROS', 'Cytosol', 'Coproporphyrinogen III', '10q26', 606938, 'Congenital erythropoietic porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (50, 'HMBS_Isoform', 'Cytosol', 'Hydroxymethylbilane', '11q23.3', 609806, 'Acute intermittent porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (60, 'ALAS1', 'Mitochondria', 'Aminolevulinic acid', '3p21.2', 125290, 'None');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (10, 1, 'Inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (10, 2, 'Activator');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (60, 1, 'Repressor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product", "chromosome", "porphyria" FROM "enzyme" WHERE ("location" = 'Cytosol') ORDER BY product, enzyme.id NULLS LAST;

/*
Gold Result:
('Coproporphyrinogen III', '1p34', 'Porphyria cutanea tarda')
('Coproporphyrinogen III', '10q26', 'Congenital erythropoietic porphyria')
('Hydroxymethylbilane', '11q23.3', 'Acute intermittent porphyria')
('Hydroxymethylbilane', '11q23.3', 'Acute intermittent porphyria')
('Porphobilinogen', '9q34', 'ALAD deficiency porphyria')
*/

-- Prediction Query
SELECT product, chromosome, porphyria FROM enzyme WHERE LOCATION = 'Cytosol';

/*
Prediction Result:
('Coproporphyrinogen III', '1p34', 'Porphyria cutanea tarda')
('Porphobilinogen', '9q34', 'ALAD deficiency porphyria')
('Hydroxymethylbilane', '11q23.3', 'Acute intermittent porphyria')
('Coproporphyrinogen III', '10q26', 'Congenital erythropoietic porphyria')
('Hydroxymethylbilane', '11q23.3', 'Acute intermittent porphyria')
*/