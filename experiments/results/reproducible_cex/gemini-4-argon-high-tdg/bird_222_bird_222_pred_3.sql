-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A_ORPHAN_1', NULL, 'c');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B_ORPHAN_1', NULL, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(CASE WHEN T.label = '+' THEN T.molecule_id ELSE NULL END) - COUNT(CASE WHEN T.label = '-' THEN T.molecule_id ELSE NULL END) AS diff_car_notcar FROM molecule AS t;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) - SUM(CASE WHEN T1.label = '-' THEN 1 ELSE 0 END) FROM molecule AS T1;

/*
Prediction Result:
(None,)
*/