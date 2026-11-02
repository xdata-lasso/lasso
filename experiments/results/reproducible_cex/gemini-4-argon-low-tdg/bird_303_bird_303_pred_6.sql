-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR007', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR008', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR006_1_2', 'TR006', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR006_2_3', 'TR006', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR006_3_4', 'TR006', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR006_4_5', 'TR006', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR007_1_2', 'TR007', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR008_1_2', 'TR008', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('BOND_NULL', NULL, '=');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_1', 'TR006', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_2', 'TR006', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR006_3', 'TR006', 'o');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR006_1', 'TR006_2', 'TR006_1_2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR006_2', 'TR006_1', 'TR006_1_2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
(2, '+')
*/

-- Prediction Query
SELECT COUNT(b.bond_id) AS double_bond_count, m.label AS molecule_label FROM bond AS b JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = ' = ' AND m.molecule_id = 'TR006' GROUP BY m.label;

/*
Prediction Result:
*/