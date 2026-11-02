-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, non-matching, NULLs, case sensitivity, and substring/prefix traps (e.g., LIKE '%TR186%').
-- Also tests extraneous INNER JOINs with the 'molecule' table via NULL label, and with 'bond'/'connected' by leaving 'TR186_1' disconnected.
INSERT INTO molecule (molecule_id, label) VALUES ('TR186', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('TR185', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR187', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('tr186', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR1860', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR186_1', 'TR186', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR186_2', 'TR186', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR186_3', 'TR186', NULL);
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR185_1', 'TR185', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR187_1', 'TR187', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('tr186_1', 'tr186', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('TR1860_1', 'TR1860', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('NULL_MOL_1', NULL, 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.atom_id FROM atom AS T WHERE T.molecule_id = 'TR186';

/*
Gold Result:
('TR186_1',)
('TR186_2',)
('TR186_3',)
*/

-- Prediction Query
SELECT T1.element FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.molecule_id = 'TR186';

/*
Prediction Result:
('c',)
('h',)
(None,)
*/