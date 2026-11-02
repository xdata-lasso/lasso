-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('i', 'i'), ('I', 'default1'), ('default1', 'I'), ('default2', 'default1'), ('unique_4', 'i'), ('unique_5', 'default1'), ('unique_6', 'default2'), ('unique_7', 'i'), ('unique_8', 'default2'), ('unique_9', 'i'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'I'), ('unique_13', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('I', 'unique_5', 'i'), ('default2', 'unique_4', NULL), ('default1', 'unique_6', 'I'), ('i', 'unique_5', 'default2'), ('unique_4', 'unique_12', 'default2'), ('unique_5', 'unique_10', 'default2'), ('unique_6', 'I', 'default2'), ('unique_7', 'I', 'default1'), ('unique_8', 'unique_12', NULL), ('unique_9', NULL, 'default1'), ('unique_10', 'unique_10', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_5', 'default2'), ('I', NULL, NULL), ('i', 'unique_7', 'I'), ('default2', 'i', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'I', 'I'), ('i', 'default2', 'unique_4'), ('i', 'i', 'unique_9'), ('I', 'default1', 'unique_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T3.bond_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T2.molecule_id = T3.molecule_id WHERE T1.element = 'i';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT bond_id) FROM connected WHERE atom_id IN (SELECT atom_id FROM atom WHERE element = 'I');

/*
Prediction Result:
(2,)
*/