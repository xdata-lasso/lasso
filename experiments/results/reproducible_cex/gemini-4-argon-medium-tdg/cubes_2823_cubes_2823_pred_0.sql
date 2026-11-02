-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'Aspirin', 'Bayer', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'Ibuprofen', 'Advil', 'Yes');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (30, 'Zymase', 'Cytosol', 'Ethanol', '1', 1001, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (10, 'Amylase', 'Saliva', 'Maltose', '2', 1002, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (20, 'Amylase', 'Pancreas', 'Glucose', '3', 1003, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (5, 'Catalase', 'Peroxisome', 'Water', '4', 1004, 'Acute');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (10, 1, 'Inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (10, 2, 'Inducer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('Amylase',)
('Amylase',)
('Catalase',)
('Zymase',)
*/

-- Prediction Query
SELECT name FROM enzyme ORDER BY name DESC, enzyme.id NULLS LAST;

/*
Prediction Result:
('Zymase',)
('Catalase',)
('Amylase',)
('Amylase',)
*/