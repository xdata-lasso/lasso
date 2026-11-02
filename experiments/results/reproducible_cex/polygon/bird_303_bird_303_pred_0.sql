-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES (' = 14', NULL, 'TR006');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('TR00613', '+15', 'TR006');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Yes22', 'TR006', '=');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('No23', 'TR006', '=');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('TR00613', 'TR00613', 'No23');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+15', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('TR006', '=24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
(2, '=24')
*/

-- Prediction Query
SELECT COUNT(bond_id) AS DoubleBonds, CASE WHEN label = '+' THEN 'Yes' ELSE 'No' END AS IsCarcinogenic FROM molecule LEFT JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE molecule.molecule_id = 'TR006' AND bond.bond_type = ' = ';

/*
Prediction Result:
(0, 'No')
*/