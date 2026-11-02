-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'ALAD', 'Cytosol', 'Porphobilinogen', '9q34', 125270, 'ADP');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'FECH', 'Mitochondria', 'Heme', '18q21.3', 612386, 'EPP');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (3, 'ALAS1', 'Mitochondria', 'Delta-ALA', '3p21.1', 125290, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (4, 'ALAD', 'Cytosol', 'Coproporphyrinogen', '9q34', 125270, 'ADP');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (5, 'HMBS', 'Cytosol', NULL, '11q23.3', 609806, 'AIP');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "enzyme" WHERE ("product" <> 'Heme') ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('ALAD',)
('ALAD',)
('ALAS1',)
*/

-- Prediction Query
SELECT name FROM enzyme WHERE product <> 'Heme';

/*
Prediction Result:
('ALAD',)
('ALAS1',)
('ALAD',)
*/