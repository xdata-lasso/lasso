-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO molecule (molecule_id, label) VALUES ('M1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('M2', '++');
INSERT INTO molecule (molecule_id, label) VALUES ('M3', ' + ');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('1234564', 'M1', 'na');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('2234564', 'M2', 'k');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('3234564', 'M3', 'li');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('4444444', 'M1', 'mg');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('444444', 'M1', 'ca');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('44444444', 'M1', 'ba');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+' AND SUBSTRING(T1.atom_id, -1) = '4' AND LENGTH(T1.atom_id) = 7;

/*
Gold Result:
('na',)
('mg',)
*/

-- Prediction Query
SELECT "atom"."element", COUNT(*) FROM "atom" INNER JOIN "molecule" ON "atom"."molecule_id" = "molecule"."molecule_id" WHERE "molecule"."label" = '+' AND SUBSTRING("atom"."atom_id", 7, 1) = '4' GROUP BY "atom"."element";

/*
Prediction Result:
('ba', 1)
('mg', 1)
('na', 1)
*/