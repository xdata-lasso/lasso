-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests:
-- 1. Same atom ('TR001_2') appearing multiple times as T2.atom_id for the same bond_id 'TR001_2_4' (connected to different atom_id2s).
-- 2. Handling of NULL element or NULL molecule_id in atom table.
-- 3. Unnecessary join to bond or molecule table where molecule_id is NULL.
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_2', NULL, 'p');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_4', NULL, NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR001_9', NULL, 's');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('TR001_2_4', NULL, NULL);
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_2', 'TR001_4', 'TR001_2_4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_2', 'TR001_9', 'TR001_2_4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('TR001_4', 'TR001_9', 'TR001_2_4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.element FROM atom AS T1 INNER JOIN connected AS T2 ON T1.atom_id = T2.atom_id WHERE T2.bond_id = 'TR001_2_4';

/*
Gold Result:
('p',)
(None,)
*/

-- Prediction Query
SELECT DISTINCT COALESCE(T2.element, T4.element) AS element FROM connected AS T1 LEFT JOIN atom AS T2 ON T1.atom_id = T2.atom_id LEFT JOIN atom AS T4 ON T1.atom_id2 = T4.atom_id WHERE T1.bond_id = 'TR001_2_4';

/*
Prediction Result:
('p',)
('s',)
*/