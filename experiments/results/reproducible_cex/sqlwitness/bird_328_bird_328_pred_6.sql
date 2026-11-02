-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', '='), ('default2', 'default1'), ('TR024', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default2', 'default1'), ('TR024', 'TR024', 'TR024'), ('default2', 'default2', NULL), ('=', 'default2', '='), ('unique_4', NULL, 'default1'), ('unique_5', NULL, 'default1'), ('unique_6', 'default2', '='), ('unique_7', NULL, 'default2'), ('unique_8', 'TR024', '='), ('unique_9', 'default1', 'TR024'), ('unique_10', NULL, 'TR024'), ('unique_11', NULL, 'default1'), ('unique_12', NULL, NULL), ('unique_13', NULL, 'default1'), ('unique_14', 'default1', 'TR024'), ('unique_15', 'default1', 'TR024'), ('unique_16', 'default2', 'default2'), ('unique_17', 'default2', NULL), ('unique_18', 'default2', NULL), ('unique_19', 'TR024', 'default2'), ('unique_20', 'default2', 'default2'), ('unique_21', 'default1', 'TR024'), ('unique_22', 'default2', 'default1'), ('unique_23', NULL, 'default2'), ('unique_24', 'TR024', 'TR024'), ('unique_25', 'default2', 'default2'), ('unique_26', 'TR024', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'TR024', NULL), ('TR024', 'default1', 'default2'), ('default1', 'TR024', 'default2'), ('=', 'TR024', 'default2'), ('unique_4', 'TR024', '='), ('unique_5', NULL, '='), ('unique_6', NULL, 'default2'), ('unique_7', 'default1', '='), ('unique_8', NULL, NULL), ('unique_9', NULL, 'default1'), ('unique_10', 'TR024', 'default1'), ('unique_11', 'default2', 'default1'), ('unique_12', 'default1', 'TR024'), ('unique_13', 'default2', 'TR024'), ('unique_14', 'TR024', '='), ('unique_15', NULL, 'TR024'), ('unique_16', 'TR024', 'TR024'), ('unique_17', 'TR024', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
(None,)
('default2',)
('default2',)
('=',)
('default1',)
('=',)
('TR024',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT atom.element FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = '=' AND bond.molecule_id = 'TR024';

/*
Prediction Result:
*/