-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES (' = ', 'default2'), ('TR047', 'default1'), ('default2', 'TR047'), ('=', 'default1'), ('default1', '='), ('unique_5', 'default2'), ('unique_6', ' = '), ('unique_7', 'TR047'), ('unique_8', 'default2'), ('unique_9', 'TR047'), ('unique_10', 'default2'), ('unique_11', ' = '), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', 'TR047'), ('unique_15', ' = ');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('default1', 'default1', 'default1'), (' = ', ' = ', 'default1'), ('TR047', 'default2', 'default1'), ('default2', 'unique_12', 'default1'), ('=', 'unique_12', '='), ('unique_5', 'unique_15', ' = '), ('unique_6', 'TR047', '='), ('unique_7', 'unique_5', '='), ('unique_8', 'TR047', 'default1'), ('unique_9', 'unique_9', ' = ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T.bond_type = '=' THEN T.bond_id ELSE NULL END) AS REAL) * 100 / COUNT(T.bond_id) FROM bond AS T WHERE T.molecule_id = 'TR047';

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN bond_type = ' = ' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM bond WHERE molecule_id = 'TR047';

/*
Prediction Result:
(0.0,)
*/