-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'ALAD', 'Cytosol', 'Porphobilinogen', '9q33.1', 125270, 'ALAD porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'HMBS', 'Cytosol', 'Hydroxymethylbilane', '11q23.3', 609806, 'Acute intermittent porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (3, 'UROS', 'Cytosol', 'Hydroxymethylbilane', '10q26.2', 606938, 'Congenital erythropoietic porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (4, 'CPOX', 'Mitochondria', 'Protoporphyrinogen IX', '3q12', 612732, 'Hereditary coproporphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (5, 'FECH', 'cytosol', 'Heme', '18q21.31', 612386, 'Erythropoietic protoporphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (6, 'UROD', NULL, 'Coproporphyrinogen III', '1p34.1', 613521, 'Porphyria cutanea tarda');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product", "chromosome", "porphyria" FROM "enzyme" WHERE ("location" = 'Cytosol') ORDER BY product, enzyme.id NULLS LAST;

/*
Gold Result:
('Hydroxymethylbilane', '11q23.3', 'Acute intermittent porphyria')
('Hydroxymethylbilane', '10q26.2', 'Congenital erythropoietic porphyria')
('Porphobilinogen', '9q33.1', 'ALAD porphyria')
*/

-- Prediction Query
SELECT product, chromosome, porphyria FROM enzyme WHERE LOCATION = 'Cytosol';

/*
Prediction Result:
('Porphobilinogen', '9q33.1', 'ALAD porphyria')
('Hydroxymethylbilane', '11q23.3', 'Acute intermittent porphyria')
('Hydroxymethylbilane', '10q26.2', 'Congenital erythropoietic porphyria')
*/