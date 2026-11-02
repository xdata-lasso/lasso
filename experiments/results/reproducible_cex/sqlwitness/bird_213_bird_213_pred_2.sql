-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR004_20', NULL), ('default2', 'default2'), ('TR004_8', 'TR004_20'), ('default1', 'TR004_8'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'TR004_20'), ('unique_7', 'TR004_8'), ('unique_8', 'default1'), ('unique_9', 'TR004_8'), ('unique_10', NULL), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', 'default1'), ('unique_14', 'default2'), ('unique_15', 'TR004_20'), ('unique_16', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR004_8', 'unique_5', 'default2'), ('default1', 'unique_16', 'TR004_20'), ('TR004_20', 'unique_7', 'TR004_20'), ('default2', 'default1', NULL), ('unique_4', 'unique_16', 'default2'), ('unique_5', 'unique_12', 'default1'), ('unique_6', 'unique_9', NULL), ('unique_7', 'default1', 'default2'), ('unique_8', 'unique_15', 'TR004_8'), ('unique_9', 'unique_10', NULL), ('unique_10', 'unique_5', NULL), ('unique_11', 'default2', 'default2'), ('unique_12', 'unique_8', 'default2'), ('unique_13', 'default2', NULL), ('unique_14', 'unique_15', 'default1'), ('unique_15', 'unique_7', 'default1'), ('unique_16', NULL, 'default2'), ('unique_17', 'unique_8', 'default2'), ('unique_18', 'unique_9', 'TR004_8'), ('unique_19', 'unique_14', 'TR004_8'), ('unique_20', 'unique_8', 'TR004_8'), ('unique_21', 'unique_6', 'default2'), ('unique_22', 'unique_13', 'default1'), ('unique_23', 'unique_14', 'TR004_20');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default1', 'TR004_20'), ('TR004_20', 'unique_15', 'default1'), ('TR004_8', 'default1', 'TR004_20'), ('default2', 'unique_15', 'TR004_8'), ('unique_4', 'unique_16', 'default2'), ('unique_5', 'default1', 'TR004_20'), ('unique_6', 'unique_6', 'default2'), ('unique_7', 'unique_11', 'TR004_8');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'default1', 'unique_22'), ('TR004_20', 'TR004_8', 'unique_23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.bond_type FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T2.atom_id = 'TR004_8' AND T2.atom_id2 = 'TR004_20' OR T2.atom_id2 = 'TR004_8' AND T2.atom_id = 'TR004_20';

/*
Gold Result:
('TR004_20',)
*/

-- Prediction Query
SELECT T2.bond_type FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T1.atom_id = 'TR004_8' AND T1.atom_id2 = 'TR004_20';

/*
Prediction Result:
*/