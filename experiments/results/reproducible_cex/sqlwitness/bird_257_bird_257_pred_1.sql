-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', NULL), ('s', NULL), ('default2', 's'), ('unique_3', 's'), ('unique_4', 'default2'), ('unique_5', 's'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 's'), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', 's'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', 'default1'), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', NULL), ('unique_19', 'default2'), ('unique_20', NULL), ('unique_21', 'default2'), ('unique_22', 'default1'), ('unique_23', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', NULL, 'default1'), ('s', 'unique_3', NULL), ('default2', 's', 's'), ('unique_3', 'unique_5', 'default2'), ('unique_4', 'unique_18', NULL), ('unique_5', 'default1', 'default2'), ('unique_6', 'unique_18', 'default2'), ('unique_7', 'unique_22', NULL), ('unique_8', 'unique_19', 'default1'), ('unique_9', 'unique_9', 's'), ('unique_10', NULL, 's'), ('unique_11', 'unique_17', NULL), ('unique_12', 'default1', 'default1'), ('unique_13', 'unique_15', 's'), ('unique_14', 'unique_22', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('s', 'unique_10', 'default2'), ('default1', 'unique_5', 's'), ('default2', 'unique_10', 'default1'), ('unique_3', 'unique_23', 's'), ('unique_4', 'unique_20', 'default1'), ('unique_5', 'unique_21', 'default2'), ('unique_6', 'unique_3', 'default2'), ('unique_7', 'unique_19', 'default1'), ('unique_8', 'unique_14', 'default1'), ('unique_9', 'unique_6', 'default2'), ('unique_10', 'unique_10', 's'), ('unique_11', NULL, 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_10', 's', 'unique_4'), ('unique_11', 'unique_4', 'unique_9'), ('unique_9', 'unique_5', 's'), ('unique_5', 'unique_8', 'unique_4'), ('unique_5', 'unique_3', 'unique_9'), ('unique_6', 'unique_6', 'unique_13'), ('unique_8', 'unique_10', 'unique_6'), ('unique_5', 'unique_9', 'unique_4'), ('unique_10', 'unique_10', 'unique_3'), ('default1', 's', 'unique_10'), ('unique_11', 'unique_6', 'unique_7'), ('unique_9', 'unique_3', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('s',)
('unique_10',)
*/

-- Prediction Query
SELECT connected.atom_id2 FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id WHERE atom.element = 's';

/*
Prediction Result:
('s',)
('s',)
('unique_10',)
*/