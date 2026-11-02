-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR144_8_19', 'default1', 'TR144_8_19'), ('default1', 'default1', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', 'default1', 'default2'), ('TR144_8_19', 'default1', NULL), ('default1', NULL, NULL), ('unique_3', NULL, 'TR144_8_19'), ('unique_4', 'default1', 'default1'), ('unique_5', NULL, 'TR144_8_19'), ('unique_6', 'default1', NULL), ('unique_7', NULL, 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'unique_6', 'TR144_8_19'), ('unique_4', 'unique_7', 'TR144_8_19'), ('TR144_8_19', 'unique_6', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.element FROM connected AS T1 INNER JOIN atom AS T2 ON T1.atom_id = T2.atom_id WHERE T1.bond_id = 'TR144_8_19';

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T1.element AS atom1_element, T2.element AS atom2_element FROM connected AS C INNER JOIN atom AS T1 ON C.atom_id = T1.atom_id INNER JOIN atom AS T2 ON C.atom_id2 = T2.atom_id WHERE C.bond_id = 'TR144_8_19';

/*
Prediction Result:
(None, None)
('default1', 'default2')
*/