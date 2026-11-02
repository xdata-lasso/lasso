-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1009, 'Patricia Galloway', 'Sharon James', 'long');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1010, 'Carla Kelly', 'Sharon James', 'prove');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1011, 'Carla Kelly', 'Sharon James', 'prove');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT trade_name, n AS count___ FROM (SELECT fda_approved, trade_name, COUNT(*) AS n FROM medicine GROUP BY fda_approved, trade_name) ORDER BY trade_name, count___ NULLS LAST;

/*
Gold Result:
('Sharon James', 1)
('Sharon James', 2)
*/

-- Prediction Query
SELECT trade_name, COUNT(*) FROM medicine GROUP BY trade_name;

/*
Prediction Result:
('Sharon James', 3)
*/