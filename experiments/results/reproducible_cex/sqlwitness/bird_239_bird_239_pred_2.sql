-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'TR%_19'), ('TR%_19', 'TR%_19'), ('19', '19'), ('default2', 'TR%_19'), ('unique_4', 'TR%_19'), ('unique_5', 'default1'), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'TR%_19');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('19', 'unique_4', 'default2'), ('TR%_19', 'unique_9', NULL), ('default2', 'default2', 'default2'), ('default1', 'unique_10', 'default2'), ('unique_4', 'unique_4', NULL), ('unique_5', 'unique_10', NULL), ('unique_6', 'unique_9', 'TR%_19'), ('unique_7', 'TR%_19', '19'), ('unique_8', NULL, '19'), ('unique_9', '19', 'default1'), ('unique_10', 'unique_5', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'unique_9', NULL), ('19', 'unique_9', 'default2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('19', '19', 'unique_6'), ('default1', 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(bond_id) FROM connected WHERE atom_id LIKE 'TR%_19';

/*
Prediction Result:
(0,)
*/