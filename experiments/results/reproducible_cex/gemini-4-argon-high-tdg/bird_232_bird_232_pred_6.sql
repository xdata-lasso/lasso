-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('TR000', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR001', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('TR002', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR003', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR040', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR020', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR010', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR050', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('TR030', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B000', 'TR000', '+');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B001', 'TR001', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B002', 'TR002', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B010', 'TR040', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B050', 'TR020', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B051', 'TR020', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B090', 'TR010', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B091', 'TR010', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B092', 'TR010', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B005', 'TR050', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('B030', 'TR030', '-');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A01', 'TR010', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A02', 'TR010', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A03', 'TR010', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A04', 'TR020', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A05', 'TR020', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A06', 'TR030', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A07', 'TR030', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A08', 'TR040', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A09', 'TR040', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A10', 'TR050', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('A11', 'TR050', 'h');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A01', 'A02', 'B090');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A02', 'A03', 'B091');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A04', 'A05', 'B050');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A06', 'A07', 'B030');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A08', 'A09', 'B010');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('A10', 'A11', 'B005');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T2.label = '-' ORDER BY T2.molecule_id LIMIT 3;

/*
Gold Result:
('TR010',)
('TR020',)
('TR030',)
*/

-- Prediction Query
SELECT molecule.molecule_id FROM molecule INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE bond.bond_type = '-' AND molecule.label = '-' ORDER BY molecule.molecule_id ASC, bond.bond_id NULLS LAST LIMIT 3;

/*
Prediction Result:
('TR010',)
('TR010',)
('TR020',)
*/