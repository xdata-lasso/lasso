-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (1, 'Zyrtec', 'Cetirizine', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (2, 'Advil', 'Ibuprofen', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (3, 'Amoxil', 'Z-Trimox', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (4, 'Amoxil', 'A-Moxatag', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (5, 'Panadol', 'Tylenol', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (6, 'Panadol', 'Tylenol', 'Yes');
INSERT INTO "medicine" ("id", "name", "Trade_Name", "FDA_approved") VALUES (7, 'ExperimentalDrug', 'ExpTrade', 'No');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (1, 'CYP3A4', 'Liver', 'MetaboliteA', '7q22.1', 124010, 'None');
INSERT INTO "enzyme" ("id", "name", "Location", "Product", "Chromosome", "OMIM", "Porphyria") VALUES (2, 'CYP2D6', 'Liver', 'MetaboliteB', '22q13.2', 124030, 'None');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1, 1, 'Inhibitor');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (2, 1, 'Substrate');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1, 7, 'Inducer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "trade_name" FROM "medicine" WHERE ("fda_approved" = 'Yes') ORDER BY name, medicine.id NULLS LAST;

/*
Gold Result:
('Advil', 'Ibuprofen')
('Amoxil', 'Z-Trimox')
('Amoxil', 'A-Moxatag')
('Panadol', 'Tylenol')
('Panadol', 'Tylenol')
('Zyrtec', 'Cetirizine')
*/

-- Prediction Query
SELECT name, trade_name FROM medicine WHERE FDA_approved = 'Yes';

/*
Prediction Result:
('Zyrtec', 'Cetirizine')
('Advil', 'Ibuprofen')
('Amoxil', 'Z-Trimox')
('Amoxil', 'A-Moxatag')
('Panadol', 'Tylenol')
('Panadol', 'Tylenol')
*/