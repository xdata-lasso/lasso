-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR000_2_5', 'default1'), ('default1', 'default2'), ('default2', 'default1'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', 'TR000_2_5'), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default1', 'TR000_2_5'), ('TR000_2_5', 'default2', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_4', 'default2'), ('TR000_2_5', 'unique_5', 'default2'), ('default2', 'unique_8', 'TR000_2_5'), ('unique_3', 'default1', 'default2'), ('unique_4', NULL, 'default2'), ('unique_5', 'unique_3', 'TR000_2_5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_4', 'unique_3', 'TR000_2_5'), ('default2', 'default1', NULL), ('TR000_2_5', 'unique_5', 'TR000_2_5'), ('TR000_2_5', 'unique_3', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM connected AS T WHERE T.bond_id = 'TR000_2_5';

/*
Gold Result:
('unique_4',)
('TR000_2_5',)
*/

-- Prediction Query
SELECT T1.atom_id, T1.atom_id2 FROM connected AS T1 INNER JOIN bond AS T2 ON T1.bond_id = T2.bond_id WHERE T2.bond_id = 'TR000_2_5';

/*
Prediction Result:
('unique_4', 'unique_3')
('TR000_2_5', 'unique_5')
*/