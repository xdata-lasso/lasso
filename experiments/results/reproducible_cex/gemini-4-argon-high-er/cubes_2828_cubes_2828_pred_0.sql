-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'B', 'TradeB', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'A', 'TradeA', 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "trade_name" FROM "medicine" WHERE ("fda_approved" = 'Yes') ORDER BY name, medicine.id NULLS LAST;

/*
Gold Result:
('A', 'TradeA')
('B', 'TradeB')
*/

-- Prediction Query
SELECT name, trade_name FROM medicine WHERE FDA_approved = 'Yes';

/*
Prediction Result:
('B', 'TradeB')
('A', 'TradeA')
*/