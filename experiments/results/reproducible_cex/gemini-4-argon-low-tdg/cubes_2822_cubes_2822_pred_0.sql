-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests composite GROUP BY (fda_approved, trade_name) vs single column GROUP BY,
-- SELECT DISTINCT mutations (by producing identical (trade_name, count___) tuples across different fda_approved groups),
-- and secondary sorting on count___ when trade_name values are tied.
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (1, 'Med1', 'Alpha', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (2, 'Med2', 'Alpha', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (3, 'Med3', 'Alpha', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (4, 'Med4', 'Beta', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (5, 'Med5', 'Beta', 'No');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (6, 'Med6', 'Gamma', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (7, 'Med7', 'Gamma', 'Yes');
INSERT INTO medicine (id, name, Trade_Name, FDA_approved) VALUES (8, 'Med8', 'Gamma', 'Yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
('Alpha', 1)
('Alpha', 2)
('Beta', 1)
('Beta', 1)
('Gamma', 3)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
('Alpha', 3)
('Beta', 2)
('Gamma', 3)
*/