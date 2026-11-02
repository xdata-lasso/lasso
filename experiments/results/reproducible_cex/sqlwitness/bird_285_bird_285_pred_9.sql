-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR001_10_11', 'TR001_10_11'), ('default1', 'default2'), ('default2', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_10_11', NULL, 'TR001_10_11'), ('default1', NULL, 'default2'), ('default2', 'TR001_10_11', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_10_11', 'default2', NULL), ('default2', 'TR001_10_11', 'default2'), ('default1', 'default2', 'TR001_10_11'), ('unique_3', 'TR001_10_11', 'default2'), ('unique_4', NULL, NULL), ('unique_5', 'TR001_10_11', 'default2'), ('unique_6', 'default2', 'TR001_10_11'), ('unique_7', 'TR001_10_11', 'default2'), ('unique_8', 'TR001_10_11', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_6', 'unique_6', NULL), ('unique_6', 'unique_5', 'default2'), ('unique_3', 'unique_5', 'default2'), ('unique_4', 'unique_6', 'default1'), ('TR001_10_11', 'default1', 'TR001_10_11'), ('default1', 'default1', 'default2'), ('unique_4', 'unique_7', 'default1'), ('default2', 'default1', NULL), ('unique_5', 'TR001_10_11', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id INNER JOIN bond AS T3 ON T2.bond_id = T3.bond_id WHERE T3.bond_id = 'TR001_10_11';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT element FROM atom WHERE atom_id = (SELECT atom_id FROM connected WHERE bond_id = 'TR001_10_11') UNION SELECT element FROM atom WHERE atom_id = (SELECT atom_id2 FROM connected WHERE bond_id = 'TR001_10_11');

/*
Prediction Result:
(None,)
('TR001_10_11',)
*/