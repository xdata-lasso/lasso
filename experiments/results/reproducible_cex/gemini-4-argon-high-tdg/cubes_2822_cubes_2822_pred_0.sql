-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'Aripiprazole_1', 'Abilify', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'Aripiprazole_2', 'Abilify', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (3, 'Aripiprazole_3', 'Abilify', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (4, 'Aripiprazole_3', 'Abilify', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (5, 'Aripiprazole_4', 'Abilify', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (6, 'Aripiprazole_5', 'Abilify', 'Pending');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (7, 'Sertraline_1', 'Zoloft', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (8, 'Sertraline_2', 'Zoloft', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (9, 'Sertraline_3', 'Zoloft', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (10, 'Sertraline_4', 'Zoloft', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (11, 'Loratadine_1', 'Claritin', 'Yes');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (1, 'CYP2D6', 'Liver', 'Hydroxylase', '22q13.2', 124030, 'None');
INSERT INTO enzyme (id, name, Location, Product, Chromosome, OMIM, Porphyria) VALUES (2, 'CYP3A4', 'Liver', 'Monooxygenase', '7q22.1', 124010, 'None');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 6, 'Substrate');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (2, 6, 'Inhibitor');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 1, 'Substrate');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
('Abilify', 1)
('Abilify', 2)
('Abilify', 3)
('Claritin', 1)
('Zoloft', 2)
('Zoloft', 2)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
('Abilify', 6)
('Claritin', 1)
('Zoloft', 4)
*/