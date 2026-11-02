-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR001_3_4', 'default1'), ('default2', NULL), ('default1', 'TR001_3_4');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default2', NULL, NULL), ('TR001_3_4', 'TR001_3_4', 'TR001_3_4');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_3_4', 'default1', NULL), ('default2', NULL, 'default1'), ('default1', NULL, 'default2'), ('unique_3', 'default2', NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('unique_3', 'unique_3', 'TR001_3_4'), ('unique_3', 'default2', 'TR001_3_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.element) FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_3_4';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(atom_id) FROM connected WHERE bond_id = 'TR001_3_4';

/*
Prediction Result:
(2,)
*/