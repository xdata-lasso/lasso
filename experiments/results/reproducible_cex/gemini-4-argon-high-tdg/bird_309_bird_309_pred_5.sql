-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR346', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR346_1', 'TR346', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR346_2', 'TR346', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_1', 'TR001', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR346_1_2', 'TR346', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR346_2_3', 'TR346', '1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR346_1_3', 'TR346', '2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_1_2', 'TR001', '3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR346_1', 'TR346_2', 'TR346_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR346_2', 'TR346_1', 'TR346_1_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.atom_id, COUNT(DISTINCT T2.bond_type) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR346' GROUP BY T1.atom_id, T2.bond_type;

/*
Gold Result:
('TR346_1', 1)
('TR346_1', 1)
('TR346_2', 1)
('TR346_2', 1)
*/

-- Prediction Query
SELECT atom_id, (SELECT COUNT(DISTINCT bond_type) FROM bond WHERE molecule_id = 'TR346') AS num_bond_types FROM atom WHERE molecule_id = 'TR346';

/*
Prediction Result:
('TR346_1', 2)
('TR346_2', 2)
*/