-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR144_8_19', 'default2'), ('default2', 'TR144_8_19'), ('default1', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'TR144_8_19');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR144_8_19', 'unique_3', 'TR144_8_19'), ('default1', 'TR144_8_19', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', NULL, NULL), ('default2', 'TR144_8_19', 'TR144_8_19'), ('TR144_8_19', 'unique_6', NULL), ('unique_3', 'unique_4', 'TR144_8_19'), ('unique_4', 'TR144_8_19', NULL), ('unique_5', 'default1', 'default2'), ('unique_6', 'unique_4', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'default1', 'default1'), ('unique_5', 'default2', 'default1'), ('unique_6', 'unique_3', 'default1'), ('unique_4', 'default2', 'default1'), ('unique_3', 'unique_6', 'TR144_8_19'), ('default2', 'unique_4', 'TR144_8_19'), ('unique_6', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR144_8_19';

/*
Gold Result:
('TR144_8_19',)
('TR144_8_19',)
*/

-- Prediction Query
SELECT t1.element AS element1, t2.element AS element2 FROM atom AS t1 JOIN connected AS c ON t1.atom_id = c.atom_id JOIN atom AS t2 ON t2.atom_id = c.atom_id2 WHERE c.bond_id = 'TR144_8_19';

/*
Prediction Result:
('TR144_8_19', 'default2')
('TR144_8_19', None)
*/