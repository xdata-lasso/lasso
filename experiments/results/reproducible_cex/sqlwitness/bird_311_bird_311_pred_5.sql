-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('default1', 'default1'), (' = ', NULL), ('s', 'default2'), ('=', 'default2'), ('default2', '='), ('unique_5', NULL), ('unique_6', '='), ('unique_7', ' = '), ('unique_8', 'default1'), ('unique_9', '='), ('unique_10', '='), ('unique_11', 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 's', 'default2'), ('s', ' = ', 'default1'), (' = ', 'unique_10', 's'), ('=', 's', 'default1');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'default2', '='), ('=', 'unique_9', 's'), ('s', 'unique_9', NULL), (' = ', 'unique_9', ' = '), ('default2', 'unique_11', 'default1'), ('unique_5', 'unique_8', NULL), ('unique_6', 'unique_8', NULL), ('unique_7', 'unique_9', 'default2'), ('unique_8', 'unique_9', ' = '), ('unique_9', 'unique_8', 'default2'), ('unique_10', ' = ', ' = '), ('unique_11', ' = ', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM molecule AS T1 LEFT JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id LEFT JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T2.element <> 's' AND T3.bond_type <> ' = ';

/*
Prediction Result:
(2,)
*/