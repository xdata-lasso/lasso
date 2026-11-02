-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('TR447', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default1', 'TR447'), ('TR447', 'default1', 'default1'), ('default1', 'default1', '#'), ('#', NULL, 'TR041'), ('TR041', 'default1', NULL), ('unique_5', 'TR447', '#'), ('unique_6', 'TR447', 'default2'), ('unique_7', NULL, '#'), ('unique_8', 'default1', NULL), ('unique_9', 'TR447', NULL), ('unique_10', 'default1', 'TR041'), ('unique_11', 'TR447', 'default1'), ('unique_12', NULL, '#'), ('unique_13', 'TR447', '#'), ('unique_14', 'TR447', NULL), ('unique_15', 'TR447', 'TR447'), ('unique_16', 'default1', 'TR041'), ('unique_17', 'default1', NULL), ('unique_18', 'default1', '#'), ('unique_19', 'default1', NULL), ('unique_20', NULL, 'default1'), ('unique_21', 'TR447', 'TR041'), ('unique_22', 'TR447', NULL), ('unique_23', 'default1', 'default2'), ('unique_24', 'default1', 'TR447'), ('unique_25', 'TR447', 'default2'), ('unique_26', 'TR447', 'TR447');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR447', 'default1', NULL), ('TR041', 'default1', 'TR041');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR447', 'TR447', 'unique_7'), ('TR041', 'TR447', 'unique_13');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.atom_id, T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_type = '#' AND T3.molecule_id = 'TR447';

/*
Gold Result:
('TR041', 'TR447')
*/

-- Prediction Query
SELECT DISTINCT c.atom_id, c.atom_id2 FROM molecule AS m INNER JOIN bond AS b ON m.molecule_id = b.molecule_id INNER JOIN connected AS c ON b.bond_id = c.bond_id WHERE m.molecule_id = 'TR041' AND b.bond_type = '#';

/*
Prediction Result:
*/