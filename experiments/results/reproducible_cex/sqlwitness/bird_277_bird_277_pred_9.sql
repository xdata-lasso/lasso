-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('default2', 'default2'), ('TR000_1_2', 'TR005_16_26');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR005_16_26', NULL, 'TR000_1_2'), ('TR000_1_2', NULL, 'TR000_1_2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR000_1_2', 'default1', 'TR000_1_2'), ('default1', NULL, 'TR005_16_26'), ('TR005_16_26', 'default2', 'TR000_1_2'), ('default2', 'default2', 'TR005_16_26'), ('unique_4', 'default2', NULL), ('unique_5', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR000_1_2', 'TR000_1_2', NULL), ('unique_5', 'TR005_16_26', 'TR000_1_2'), ('TR005_16_26', 'default1', 'TR005_16_26'), ('unique_5', 'default1', NULL), ('default1', 'TR000_1_2', 'TR005_16_26'), ('default1', 'TR005_16_26', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR005_16_26';

/*
Gold Result:
('TR000_1_2',)
('TR005_16_26',)
*/

-- Prediction Query
SELECT DISTINCT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR000_1_2' UNION SELECT DISTINCT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id2 = T2.atom_id WHERE T1.bond_id = 'TR000_1_2';

/*
Prediction Result:
(None,)
('TR000_1_2',)
*/