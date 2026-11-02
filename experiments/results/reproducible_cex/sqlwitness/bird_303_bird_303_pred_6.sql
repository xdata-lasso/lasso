-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR006', 'default2'), ('default2', '='), ('default1', 'default2'), ('=', 'default1'), (' = ', '='), ('unique_5', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('=', 'default2', ' = '), ('default1', 'TR006', NULL), (' = ', 'TR006', NULL), ('default2', ' = ', NULL), ('TR006', ' = ', 'TR006'), ('unique_5', 'default1', 'default2'), ('unique_6', 'TR006', 'default2'), ('unique_7', 'unique_5', '='), ('unique_8', 'default2', 'TR006'), ('unique_9', '=', NULL), ('unique_10', NULL, 'default1'), ('unique_11', 'TR006', 'default1'), ('unique_12', 'unique_5', 'default1'), ('unique_13', 'TR006', '=');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.bond_id), T2.label FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=' AND T2.molecule_id = 'TR006' GROUP BY T2.label;

/*
Gold Result:
(1, 'default2')
*/

-- Prediction Query
SELECT COUNT(b.bond_id) AS double_bond_count, m.label AS molecule_label FROM bond AS b JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = ' = ' AND m.molecule_id = 'TR006' GROUP BY m.label;

/*
Prediction Result:
*/