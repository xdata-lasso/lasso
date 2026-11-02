-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enzyme (id, name, location, product, chromosome, omim, porphyria) VALUES (0, NULL, 'Cytosol', 'default2', 'Cytosol', 0, 'default2'), (1, NULL, 'default2', 'default2', NULL, 1, 'default2'), (2, 'Cytosol', 'default1', 'default1', NULL, 0, 'default2'), (3, 'default2', 'default1', 'default2', 'default1', 0, 'default2'), (4, 'default2', 'Cytosol', 'default1', 'Cytosol', 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "product", "chromosome", "porphyria" FROM "enzyme" WHERE ("location" = 'Cytosol') ORDER BY product, enzyme.id NULLS LAST;

/*
Gold Result:
('default1', 'Cytosol', 'default2')
('default2', 'Cytosol', 'default2')
*/

-- Prediction Query
SELECT product, chromosome, porphyria FROM enzyme WHERE LOCATION = 'Cytosol';

/*
Prediction Result:
('default2', 'Cytosol', 'default2')
('default1', 'Cytosol', 'default2')
*/