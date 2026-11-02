-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('_1', 'TR009'), ('default2', 'default1'), ('TR009_12', 'TR009_12'), ('_2', 'TR009'), ('TR009', 'TR009_12'), ('unique_6', 'TR009_12'), ('unique_7', '_1'), ('unique_8', 'TR009_12'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', '_1'), ('unique_12', '_1'), ('unique_13', 'default1'), ('unique_14', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('_2', 'unique_14', '_1'), ('default2', 'default1', 'default2'), ('TR009_12', NULL, 'TR009_12'), ('_1', 'unique_10', NULL), ('default1', 'TR009', 'default2'), ('TR009', 'default1', NULL), ('unique_6', 'default1', 'TR009_12'), ('unique_7', 'unique_7', '_1'), ('unique_8', NULL, '_1'), ('unique_9', 'TR009_12', '_1'), ('unique_10', 'unique_6', 'TR009_12'), ('unique_11', '_2', 'default2'), ('unique_12', 'unique_6', 'default1'), ('unique_13', 'unique_13', '_2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'unique_7', '_1'), ('TR009_12', 'unique_12', 'default2'), ('TR009', '_1', NULL), ('default1', '_1', 'default1'), ('_2', 'default2', NULL), ('_1', '_2', 'default1'), ('unique_6', 'unique_14', 'default1'), ('unique_7', 'unique_13', 'default1'), ('unique_8', '_2', 'TR009'), ('unique_9', '_2', 'TR009_12'), ('unique_10', 'unique_10', 'default1'), ('unique_11', NULL, 'TR009_12'), ('unique_12', 'unique_14', 'default2'), ('unique_13', NULL, '_2'), ('unique_14', 'TR009_12', '_1'), ('unique_15', '_2', 'TR009_12'), ('unique_16', 'unique_12', 'default1'), ('unique_17', 'unique_7', 'default2'), ('unique_18', NULL, 'TR009_12'), ('unique_19', '_1', NULL), ('unique_20', 'TR009_12', '_1'), ('unique_21', 'unique_9', 'TR009'), ('unique_22', NULL, 'TR009'), ('unique_23', 'unique_12', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR009_12', 'unique_15', 'TR009_12'), ('unique_14', 'unique_17', 'unique_10'), ('_2', 'TR009', 'unique_9'), ('unique_21', 'unique_16', 'unique_11'), ('_1', 'default2', 'TR009_12'), ('unique_8', 'unique_23', NULL), ('TR009_12', 'unique_20', '_2'), ('TR009_12', 'unique_12', NULL), ('unique_15', 'unique_16', 'unique_9'), ('unique_10', 'unique_12', '_1'), ('_1', 'unique_21', 'unique_12'), ('unique_20', 'default2', 'unique_10'), ('unique_8', 'unique_6', 'TR009_12'), ('TR009_12', 'unique_16', 'unique_11'), ('unique_8', 'unique_11', '_2'), ('unique_12', 'default2', 'unique_9'), ('unique_10', 'TR009', '_1'), ('TR009', '_1', 'unique_9'), ('unique_18', 'unique_15', 'unique_6'), ('unique_19', 'unique_15', 'unique_10'), ('default2', 'unique_14', 'default2'), ('_1', 'TR009_12', 'default1'), ('unique_13', 'unique_18', 'unique_10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.bond_id) FROM bond AS T1 INNER JOIN connected AS T2 ON T1.bond_id = T2.bond_id WHERE T1.molecule_id = 'TR009' AND T2.atom_id = T1.molecule_id || '_1' AND T2.atom_id2 = T1.molecule_id || '_2';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM bond JOIN connected ON bond.bond_id = connected.bond_id WHERE bond.molecule_id = 'TR009' AND (connected.atom_id = 'TR009_12' OR connected.atom_id2 = 'TR009_12');

/*
Prediction Result:
(1,)
*/