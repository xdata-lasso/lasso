-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('c', NULL), ('default2', '-'), ('#', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'c', NULL), ('#', 'default2', '#'), ('c', NULL, '-'), ('-', NULL, 'default2'), ('default2', '#', NULL), ('unique_5', '#', '-'), ('unique_6', '#', 'default2'), ('unique_7', 'default2', 'c'), ('unique_8', 'default2', 'default1'), ('unique_9', 'c', '-'), ('unique_10', NULL, '#'), ('unique_11', '#', 'default1'), ('unique_12', 'default2', '#'), ('unique_13', NULL, NULL), ('unique_14', 'default2', 'c'), ('unique_15', '#', NULL), ('unique_16', 'c', 'c'), ('unique_17', 'default2', 'default2'), ('unique_18', 'c', 'default2'), ('unique_19', 'default2', NULL), ('unique_20', 'default2', 'default1'), ('unique_21', 'default2', 'default2'), ('unique_22', 'c', 'default1'), ('unique_23', 'c', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('-', '#', 'default1'), ('#', '#', '-'), ('default2', NULL, NULL), ('default1', 'default2', '-'), ('c', 'default2', 'default1'), ('unique_5', NULL, NULL), ('unique_6', '#', '#'), ('unique_7', 'default2', '#'), ('unique_8', '#', 'default2'), ('unique_9', '#', 'c'), ('unique_10', 'default2', 'default2'), ('unique_11', '#', 'c'), ('unique_12', NULL, 'c'), ('unique_13', 'c', 'c'), ('unique_14', 'c', '-'), ('unique_15', '#', 'default2'), ('unique_16', 'c', '-'), ('unique_17', 'default2', NULL), ('unique_18', '#', 'default2'), ('unique_19', 'default2', '-'), ('unique_20', 'c', '-'), ('unique_21', 'c', 'default1'), ('unique_22', 'c', NULL), ('unique_23', '#', 'default1'), ('unique_24', '#', '#'), ('unique_25', '#', 'c'), ('unique_26', NULL, 'c'), ('unique_27', NULL, 'default2'), ('unique_28', 'c', 'default1'), ('unique_29', 'c', 'c'), ('unique_30', NULL, 'default2'), ('unique_31', '#', 'c'), ('unique_32', 'default2', '-'), ('unique_33', 'default2', 'c'), ('unique_34', '#', 'default1'), ('unique_35', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T1.element = 'c' AND T2.label = '-';

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT molecule.molecule_id FROM molecule INNER JOIN atom ON molecule.molecule_id = atom.molecule_id INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE atom.element = 'c' AND bond.bond_type = '#' AND molecule.label = '-' LIMIT 2;

/*
Prediction Result:
('default2',)
('default2',)
*/