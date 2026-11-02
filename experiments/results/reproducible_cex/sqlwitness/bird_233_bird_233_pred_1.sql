-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), ('default2', NULL), ('TR006', 'TR006'), ('unique_3', NULL), ('unique_4', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default1', NULL), ('TR006', 'unique_4', 'default1'), ('default2', 'TR006', 'TR006'), ('unique_3', 'TR006', 'default2'), ('unique_4', 'unique_4', 'default1'), ('unique_5', 'default1', 'default2'), ('unique_6', 'TR006', 'default2'), ('unique_7', 'default2', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'TR006', 'default2'), ('default1', 'default2', 'default1'), ('TR006', 'default1', 'default1'), ('unique_3', 'unique_4', 'default2'), ('unique_4', 'unique_3', NULL), ('unique_5', 'default2', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'TR006', 'unique_5'), ('TR006', 'unique_5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.bond_id FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T1.molecule_id = 'TR006' ORDER BY T2.bond_id LIMIT 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT bond_id FROM bond WHERE molecule_id = 'TR006' ORDER BY bond_id ASC LIMIT 2;

/*
Prediction Result:
('default2',)
('unique_3',)
*/