-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', 'TR010');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('-', 'TR010', 'TR004'), ('TR004', NULL, NULL), ('default1', NULL, NULL), ('default2', NULL, 'default1'), ('TR010', 'TR010', 'TR010'), ('unique_5', 'TR010', '-'), ('unique_6', NULL, '-'), ('unique_7', 'TR010', 'TR004'), ('unique_8', NULL, 'default1'), ('unique_9', NULL, 'default2'), ('unique_10', NULL, '-'), ('unique_11', 'TR010', 'default1'), ('unique_12', 'TR010', 'default2'), ('unique_13', NULL, 'default2'), ('unique_14', 'TR010', '-'), ('unique_15', NULL, 'default1'), ('unique_16', 'TR010', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T.molecule_id) FROM bond AS T WHERE T.molecule_id BETWEEN 'TR004' AND 'TR010' AND T.bond_type = '-';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(T1.molecule_id) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.molecule_id BETWEEN 'TR004' AND 'TR010';

/*
Prediction Result:
(2,)
*/