-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'Amisulpride', 'Solian', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'Bortezomib', 'Velcade', 'Yes');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'Ferrochelatase', 'Mitochondria', 'Heme', '18q21.3', 177000, 'Erythropoietic protoporphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'Uroporphyrinogen III synthase', 'Cytosol', 'Uroporphyrinogen III', '10q25.2-q26.3', 606938, 'Congenital erythropoietic porphyria');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (3, 'ALA synthase', 'Mitochondria', 'Delta-aminolevulinic acid', '3p21.1', 125290, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (4, 'PBG deaminase', 'Cytosol', 'Hydroxymethylbilane', '11q23.3', 609806, 'Acute intermittent porphyria');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1, 1, 'Inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (2, 1, 'Inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (2, 2, 'Activator');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "enzyme" WHERE ("product" <> 'Heme') ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('ALA synthase',)
('PBG deaminase',)
('Uroporphyrinogen III synthase',)
*/

-- Prediction Query
SELECT name FROM enzyme WHERE product <> 'Heme';

/*
Prediction Result:
('Uroporphyrinogen III synthase',)
('ALA synthase',)
('PBG deaminase',)
*/