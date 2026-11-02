-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO molecule (molecule_id, label) VALUES ('TR050', 'TR010'), ('default2', 'default2'), ('TR010', 'c'), ('c', 'TR010'), ('C%', 'TR050'), ('default1', 'default2'), ('unique_6', 'default2');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('default1', 'TR050', 'TR050'), ('default2', 'unique_6', 'c'), ('C%', 'TR010', 'TR010'), ('TR050', 'TR050', 'C%'), ('c', 'C%', 'default2'), ('TR010', 'default2', 'default1'), ('unique_6', 'default1', 'default1'), ('unique_7', 'TR010', 'default1'), ('unique_8', 'unique_6', 'c'), ('unique_9', 'default2', 'c'), ('unique_10', 'default1', 'TR010'), ('unique_11', 'default2', 'c'), ('unique_12', 'TR010', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id BETWEEN 'TR010' AND 'TR050' AND T.element = 'c';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.atom_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element LIKE 'C%' AND T2.molecule_id >= 'TR010' AND T2.molecule_id <= 'TR050';

/*
Prediction Result:
('TR050',)
*/