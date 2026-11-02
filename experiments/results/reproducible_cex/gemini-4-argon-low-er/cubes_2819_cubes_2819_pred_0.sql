-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'Enzyme1', 'Cytosol', 'Z', 'Chr1', 100, 'P1');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'Enzyme2', 'Cytosol', 'A', 'Chr2', 200, 'P2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product", "chromosome", "porphyria" FROM "enzyme" WHERE ("location" = 'Cytosol') ORDER BY product, enzyme.id NULLS LAST;

/*
Gold Result:
('A', 'Chr2', 'P2')
('Z', 'Chr1', 'P1')
*/

-- Prediction Query
SELECT product, chromosome, porphyria FROM enzyme WHERE LOCATION = 'Cytosol';

/*
Prediction Result:
('Z', 'Chr1', 'P1')
('A', 'Chr2', 'P2')
*/