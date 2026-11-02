-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2'), ('default2', NULL), ('s', NULL), ('unique_3', 's'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 's'), ('unique_7', 's'), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', 'default1'), ('unique_11', 's'), ('unique_12', 's'), ('unique_13', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', 'default1', 'default1'), ('default1', 'default2', 's'), ('s', 'default2', NULL), ('unique_3', 'default1', NULL), ('unique_4', 's', 'default1'), ('unique_5', 'unique_13', 's'), ('unique_6', NULL, NULL), ('unique_7', 'default2', 's'), ('unique_8', 'unique_6', NULL), ('unique_9', 'unique_7', 'default1'), ('unique_10', 's', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('s', 'unique_3', 'default1'), ('default2', 'default2', 'default1'), ('default1', 'unique_3', 's'), ('unique_3', 'unique_7', 's'), ('unique_4', 'unique_8', 's'), ('unique_5', 'unique_5', 's'), ('unique_6', 'unique_10', NULL), ('unique_7', 'unique_9', 'default1'), ('unique_8', 'default2', NULL), ('unique_9', 'default2', NULL), ('unique_10', 'unique_6', NULL), ('unique_11', 'unique_13', 's');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 'unique_10', 's'), ('unique_10', 'unique_3', 'unique_10'), ('unique_11', 'unique_6', 's'), ('unique_6', 'unique_11', 'unique_4'), ('s', 'default1', 'default1'), ('unique_4', 'unique_4', 'default1'), ('unique_5', 'default1', 'unique_3'), ('unique_8', 'unique_8', 'default2'), ('unique_6', 'unique_3', 'unique_10'), ('default2', 'unique_9', 'default1'), ('unique_3', 'unique_6', 'unique_3'), ('default2', 's', 'unique_10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('unique_10',)
('unique_6',)
('unique_4',)
('default1',)
*/

-- Prediction Query
SELECT atom_id2 FROM connected WHERE atom_id IN (SELECT atom_id FROM atom WHERE element = 's');

/*
Prediction Result:
('unique_6',)
('unique_10',)
('unique_6',)
('unique_4',)
('default1',)
*/