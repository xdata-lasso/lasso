-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('s', 's'), ('default2', 's'), ('default1', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, NULL), ('default1', NULL, 's'), ('s', NULL, 'default2'), ('unique_3', 'default1', 'default1'), ('unique_4', NULL, 'default2'), ('unique_5', NULL, 'default1'), ('unique_6', 'default2', 'default2'), ('unique_7', 'default2', 'default1'), ('unique_8', NULL, 'default1'), ('unique_9', 's', NULL), ('unique_10', 'default2', 'default2'), ('unique_11', 's', 'default1'), ('unique_12', 'default2', 's'), ('unique_13', 'default2', NULL), ('unique_14', NULL, 'default1'), ('unique_15', 'default2', 'default2'), ('unique_16', NULL, 's'), ('unique_17', NULL, 'default2'), ('unique_18', NULL, 'default1'), ('unique_19', NULL, 'default1'), ('unique_20', NULL, 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default2', 's'), ('s', 's', NULL), ('default1', 's', NULL), ('unique_3', 'default2', 's'), ('unique_4', NULL, 's');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 's', 'unique_19'), ('default2', 'unique_3', 's'), ('unique_4', 'unique_4', 'unique_9'), ('s', 'default2', 'unique_9'), ('unique_4', 's', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Gold Result:
('unique_3',)
('s',)
('unique_4',)
*/

-- Prediction Query
SELECT T2.atom_id2 FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.element = 's';

/*
Prediction Result:
('unique_3',)
('s',)
('s',)
('unique_4',)
*/