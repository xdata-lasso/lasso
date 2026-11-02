-- Schema DDL
CREATE TABLE "medicine" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Trade_Name" TEXT, "FDA_approved" TEXT);

CREATE TABLE "enzyme" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Location" TEXT, "Product" TEXT, "Chromosome" TEXT, "OMIM" INTEGER, "Porphyria" TEXT);

CREATE TABLE "medicine_enzyme_interaction" ("enzyme_id" INTEGER, "medicine_id" INTEGER, "interaction_type" TEXT, PRIMARY KEY ("enzyme_id", "medicine_id"), FOREIGN KEY ("medicine_id") REFERENCES "medicine" ("id"), FOREIGN KEY ("enzyme_id") REFERENCES "enzyme" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1004, 'Donald Lewis', '61559 Roman Stream
Herrerafurt, CO 72858', 'finally', 'themselves', 1005, 'production');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1007, 'Sharon James', '55341 Amanda Gardens Apt. 764
Lake Mark, WI 07832', 'drop', 'term', 1008, 'almost');
INSERT INTO "enzyme" ("id", "name", "location", "product", "chromosome", "omim", "porphyria") VALUES (1010, 'Dr. Marvin Thomas Jr.', '969 Cox Dam Suite 101
Lake Ernest, TX 55834', 'pick', 'attack', 1011, 'image');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1006, 'Shannon Ray', 'Amber Perez', 'figure');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1009, NULL, 'Latoya Robbins', 'difference');
INSERT INTO "medicine" ("id", "name", "trade_name", "fda_approved") VALUES (1012, 'Zachary Rice', 'Shannon Smith', 'set');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1004, 1006, 'base');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1007, 1009, 'reality');
INSERT INTO "medicine_enzyme_interaction" ("enzyme_id", "medicine_id", "interaction_type") VALUES (1010, 1009, 'building');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT id, name, fda_approved FROM (SELECT id, name, trade_name, fda_approved, enzyme_id, interaction_type, id AS medicine_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.trade_name AS trade_name, LHS.fda_approved AS fda_approved, RHS.enzyme_id AS enzyme_id, RHS.interaction_type AS interaction_type FROM medicine AS LHS INNER JOIN medicine_enzyme_interaction AS RHS ON (LHS.id = RHS.medicine_id))) ORDER BY id, name NULLS LAST, fda_approved NULLS LAST;

/*
Gold Result:
(1006, 'Shannon Ray', 'figure')
(1009, None, 'difference')
*/

-- Prediction Query
SELECT T1.id, T1.Name, T1.FDA_approved FROM medicine AS T1 JOIN medicine_enzyme_interaction AS T2 ON T2.medicine_id = T1.id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.id NULLS LAST, T1.Name NULLS LAST, T1.FDA_approved NULLS LAST;

/*
Prediction Result:
(1009, None, 'difference')
(1006, 'Shannon Ray', 'figure')
*/