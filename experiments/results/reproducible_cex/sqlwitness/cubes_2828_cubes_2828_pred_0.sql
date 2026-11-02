-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO medicine (id, name, trade_name, fda_approved) VALUES (1, NULL, 'default1', 'Yes'), (0, NULL, 'Yes', NULL), (2, 'default1', NULL, NULL), (3, 'Yes', 'default2', 'default1'), (4, 'default2', 'default1', 'default2'), (5, 'Yes', NULL, 'Yes'), (6, NULL, 'default2', 'Yes'), (7, 'Yes', 'default2', NULL), (8, NULL, NULL, 'default2'), (9, 'Yes', 'default1', 'default1'), (10, 'default2', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "trade_name" FROM "medicine" WHERE ("fda_approved" = 'Yes') ORDER BY name, medicine.id NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, 'default2')
('Yes', None)
*/

-- Prediction Query
SELECT name, trade_name FROM medicine WHERE FDA_approved = 'Yes';

/*
Prediction Result:
(None, 'default1')
('Yes', None)
(None, 'default2')
*/