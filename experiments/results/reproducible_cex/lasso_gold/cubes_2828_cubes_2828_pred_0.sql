-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1014, 'Kimberly Burgess', 'Brenda Taylor', 'Yes');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1015, 'Jennifer Jones', 'Latoya Robbins', 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "trade_name" FROM "medicine" WHERE ("fda_approved" = 'Yes') ORDER BY name, medicine.id NULLS LAST;

/*
Gold Result:
('Jennifer Jones', 'Latoya Robbins')
('Kimberly Burgess', 'Brenda Taylor')
*/

-- Prediction Query
SELECT name, trade_name FROM medicine WHERE FDA_approved = 'Yes';

/*
Prediction Result:
('Kimberly Burgess', 'Brenda Taylor')
('Jennifer Jones', 'Latoya Robbins')
*/