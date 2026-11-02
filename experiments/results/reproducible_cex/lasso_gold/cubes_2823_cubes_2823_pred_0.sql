-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1006, 'Thomas Miller', '310 Kendra Common Apt. 164
Reidstad, GA 49021', 'drop', 'determine', 1007, 'almost');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1008, 'Jennifer Jones', '327 Nelson Route
Lake Mark, WI 07832', 'hear', 'term', 1008, 'religious');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM enzyme ORDER BY name, enzyme.id NULLS LAST;

/*
Gold Result:
('Jennifer Jones',)
('Thomas Miller',)
*/

-- Prediction Query
SELECT name FROM enzyme ORDER BY name DESC, enzyme.id NULLS LAST;

/*
Prediction Result:
('Thomas Miller',)
('Jennifer Jones',)
*/