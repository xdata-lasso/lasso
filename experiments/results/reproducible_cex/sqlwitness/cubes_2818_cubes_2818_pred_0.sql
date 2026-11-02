-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enzyme (id, name, location, product, chromosome, omim, porphyria) VALUES (2, 'default2', 'default1', NULL, 'default2', NULL, 'default2'), (1, NULL, NULL, 'default1', 'default2', 0, 'default2');
INSERT INTO medicine (id, name, trade_name, fda_approved) VALUES (0, 'default1', 'default2', 'default1'), (2, NULL, 'default1', 'default2');
INSERT INTO medicine_enzyme_interaction (enzyme_id, medicine_id, interaction_type) VALUES (1, 2, NULL), (2, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT interaction_type, n AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT interaction_type, COUNT(*) AS n FROM medicine_enzyme_interaction GROUP BY interaction_type) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT interaction_type, COUNT(*) FROM medicine_enzyme_interaction GROUP BY interaction_type ORDER BY COUNT(*) DESC, interaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1', 1)
*/