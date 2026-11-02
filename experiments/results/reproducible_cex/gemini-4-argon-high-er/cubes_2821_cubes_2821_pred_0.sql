-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enzyme (id, name, Location) VALUES (1, 'B', 'Loc1');
INSERT INTO enzyme (id, name, Location) VALUES (2, 'A', 'Loc2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, LOCATION FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('A', 'Loc2')
('B', 'Loc1')
*/

-- Prediction Query
SELECT name, LOCATION FROM enzyme;

/*
Prediction Result:
('B', 'Loc1')
('A', 'Loc2')
*/