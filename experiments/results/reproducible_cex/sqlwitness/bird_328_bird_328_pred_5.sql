-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR024', NULL), ('=', 'TR024'), ('default1', 'default1'), (' = ', 'default1'), ('default2', 'TR024'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'TR024'), ('unique_9', '='), ('unique_10', 'default2'), ('unique_11', 'TR024'), ('unique_12', 'default1'), ('unique_13', ' = '), ('unique_14', 'default2');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR024', 'unique_12', 'default1'), (' = ', ' = ', 'default2'), ('=', 'unique_13', 'TR024'), ('default1', 'unique_9', NULL), ('default2', 'unique_8', 'default2'), ('unique_5', '=', '='), ('unique_6', 'unique_13', 'TR024'), ('unique_7', 'TR024', '='), ('unique_8', 'unique_7', NULL), ('unique_9', 'default1', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES (' = ', '=', NULL), ('default1', 'unique_5', 'default2'), ('TR024', NULL, ' = '), ('=', 'unique_14', NULL), ('default2', 'TR024', ' = '), ('unique_5', 'unique_12', 'default1'), ('unique_6', 'unique_13', ' = '), ('unique_7', 'unique_12', ' = '), ('unique_8', 'unique_14', 'TR024'), ('unique_9', 'unique_9', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.element FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.molecule_id = 'TR024' AND T2.bond_type = '=';

/*
Gold Result:
(' = ',)
*/

-- Prediction Query
SELECT DISTINCT a.element FROM bond AS b INNER JOIN atom AS a ON b.molecule_id = a.molecule_id WHERE b.bond_type = ' = ' AND a.molecule_id = 'TR024';

/*
Prediction Result:
*/