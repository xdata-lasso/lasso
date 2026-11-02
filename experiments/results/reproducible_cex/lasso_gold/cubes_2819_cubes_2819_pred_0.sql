-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1030, 'Nicole Mack', 'Cytosol', 'set', 'brother', 1031, 'finally');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1032, 'Shannon Smith', 'Cytosol', 'learn', 'building', 1032, 'rest');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product", "chromosome", "porphyria" FROM "enzyme" WHERE ("location" = 'Cytosol') ORDER BY product, enzyme.id NULLS LAST;

/*
Gold Result:
('learn', 'building', 'rest')
('set', 'brother', 'finally')
*/

-- Prediction Query
SELECT product, chromosome, porphyria FROM enzyme WHERE LOCATION = 'Cytosol';

/*
Prediction Result:
('set', 'brother', 'finally')
('learn', 'building', 'rest')
*/