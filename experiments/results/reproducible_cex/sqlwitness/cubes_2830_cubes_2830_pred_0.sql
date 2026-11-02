-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enzyme (id, name, location, product, chromosome, omim, porphyria) VALUES (0, 'default1', 'default1', 'Heme', 'Heme', NULL, NULL), (1, 'default2', 'Heme', 'default1', 'default1', 1, 'default2'), (2, 'default2', 'Heme', NULL, 'default1', 0, NULL), (3, 'Heme', 'default1', 'default2', 'default1', 1, 'Heme');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "enzyme" WHERE ("product" <> 'Heme') ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('Heme',)
('default2',)
*/

-- Prediction Query
SELECT name FROM enzyme WHERE product <> 'Heme';

/*
Prediction Result:
('default2',)
('Heme',)
*/