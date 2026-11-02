-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality vs equality ('Heme'), case sensitivity ('heme'), substring/LIKE mutations ('Heme A'), and NULL handling in WHERE clause.
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'ALA synthase', 'Mitochondria', 'Delta-ALA', '3p21.1', 125290, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'Ferrochelatase', 'Mitochondria', 'Heme', '18q21.3', 177000, 'Erythropoietic protoporphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (3, 'Heme synthase', 'Mitochondria', 'heme', '18q21.3', 177001, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (4, 'COX10', 'Mitochondria', 'Heme A', '17p12', 602125, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (5, 'Unknown Enzyme', 'Cytosol', NULL, '1p11', 100000, 'None');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "enzyme" WHERE ("product" <> 'Heme') ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('ALA synthase',)
('COX10',)
('Heme synthase',)
*/

-- Prediction Query
SELECT name FROM enzyme WHERE product <> 'Heme';

/*
Prediction Result:
('ALA synthase',)
('Heme synthase',)
('COX10',)
*/