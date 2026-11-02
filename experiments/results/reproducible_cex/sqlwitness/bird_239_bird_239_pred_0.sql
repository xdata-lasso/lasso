-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', NULL), ('19', 'default1'), ('default1', 'default1'), ('TR%_19', 'default1'), ('unique_4', 'default1'), ('unique_5', 'TR%_19'), ('unique_6', NULL), ('unique_7', NULL);
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR%_19', 'unique_5', '19'), ('default1', 'unique_4', 'TR%_19'), ('default2', 'unique_7', NULL), ('19', 'unique_7', NULL), ('unique_4', 'unique_5', 'TR%_19'), ('unique_5', 'unique_4', '19'), ('unique_6', NULL, 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default2', '19', 'default2'), ('default1', '19', 'default1'), ('TR%_19', 'unique_6', 'default1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('default1', 'default2', 'default1'), ('TR%_19', 'default2', 'unique_4'), ('default2', 'TR%_19', 'unique_5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T.bond_id) FROM connected AS T WHERE SUBSTRING(T.atom_id, -2) = '19';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(bond_id) FROM connected WHERE atom_id LIKE 'TR%_19' OR atom_id2 LIKE 'TR%_19';

/*
Prediction Result:
(2,)
*/