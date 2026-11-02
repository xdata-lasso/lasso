-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by name, duplicate output elimination (DISTINCT vs ALL), and column mapping (Location vs Product/Porphyria).
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'Catalase', 'Peroxisome', 'H2O', '11p13', 115500, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'Aldolase', 'Cytoplasm', 'Pyruvate', '16q22', 103850, 'Acute');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (3, 'Aldolase', 'Cytoplasm', 'Lactate', '17q23', 103851, 'Congenital');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('Aldolase', 'Cytoplasm')
('Aldolase', 'Cytoplasm')
('Catalase', 'Peroxisome')
*/

-- Prediction Query
SELECT name, LOCATION FROM enzyme;

/*
Prediction Result:
('Catalase', 'Peroxisome')
('Aldolase', 'Cytoplasm')
('Aldolase', 'Cytoplasm')
*/