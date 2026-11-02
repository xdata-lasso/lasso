-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default2', 'default1'), ('=', '='), ('s', 'default1'), ('default1', '='), (' = ', 'default2'), ('unique_5', 's'), ('unique_6', 'default1');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', 'unique_5', '='), ('default1', 'unique_5', 's'), ('s', 'default1', NULL), ('default2', 's', NULL), (' = ', 's', 'default1'), ('unique_5', NULL, NULL), ('unique_6', 's', NULL), ('unique_7', NULL, NULL), ('unique_8', 'unique_6', ' = ');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('=', '=', NULL), (' = ', NULL, ' = '), ('default1', '=', 's'), ('s', 's', 'default2'), ('default2', NULL, 'default1'), ('unique_5', NULL, 'default1'), ('unique_6', 'unique_5', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) AS result FROM atom AS a INNER JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE a.element <> 's' AND b.bond_type <> ' = ';

/*
Prediction Result:
(3,)
*/