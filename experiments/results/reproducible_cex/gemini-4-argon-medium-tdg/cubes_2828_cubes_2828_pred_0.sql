-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering ('Yes' vs 'No', 'yes', 'YES', NULL, 'YesAndMore'), column selection, and ORDER BY name.
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'Zidovudine', 'Retrovir', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'Aspirin', 'Ecotrin', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (3, 'Ibuprofen', 'Advil', 'No');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (4, 'Acetaminophen', 'Tylenol', 'yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (5, 'Naproxen', 'Aleve', 'YES');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (6, 'ExperimentalDrug', 'Exp', NULL);
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (7, 'PartialMatch', 'Part', 'Yes_Pending');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "trade_name" FROM "medicine" WHERE ("fda_approved" = 'Yes') ORDER BY name, medicine.id NULLS LAST;

/*
Gold Result:
('Aspirin', 'Ecotrin')
('Zidovudine', 'Retrovir')
*/

-- Prediction Query
SELECT name, trade_name FROM medicine WHERE FDA_approved = 'Yes';

/*
Prediction Result:
('Zidovudine', 'Retrovir')
('Aspirin', 'Ecotrin')
*/