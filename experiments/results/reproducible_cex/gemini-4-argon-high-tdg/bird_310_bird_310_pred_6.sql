-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO molecule (molecule_id, label) VALUES ('m1', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m2', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m3', '-');
INSERT INTO molecule (molecule_id, label) VALUES ('m4', '+');
INSERT INTO molecule (molecule_id, label) VALUES ('m5', NULL);
INSERT INTO molecule (molecule_id, label) VALUES ('m6', '+');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a1', 'm1', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a2', 'm1', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a3', 'm1', 'n');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a4', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a5', 'm2', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a6', 'm3', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a7', 'm3', 'o');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a8', 'm4', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a9', 'm4', 'h');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a10', 'm5', 'c');
INSERT INTO atom (atom_id, molecule_id, element) VALUES ('a11', 'm5', 'o');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b1', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b2', 'm1', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b3', 'm1', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b4', 'm2', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b5', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b6', 'm3', '=');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b7', 'm4', '-');
INSERT INTO bond (bond_id, molecule_id, bond_type) VALUES ('b8', 'm5', '=');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a2', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a1', 'b1');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a2', 'a3', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a2', 'b2');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a1', 'a3', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a3', 'a1', 'b3');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a4', 'a5', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a5', 'a4', 'b4');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a6', 'a7', 'b5');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a7', 'a6', 'b6');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a8', 'a9', 'b7');
INSERT INTO connected (atom_id, atom_id2, bond_id) VALUES ('a10', 'a11', 'b8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T2.molecule_id), SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) FROM bond AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.bond_type = '=';

/*
Gold Result:
(4, 3)
*/

-- Prediction Query
SELECT COUNT(DISTINCT b.molecule_id) AS total_double_bonds, COUNT(DISTINCT CASE WHEN m.label = '+' THEN b.molecule_id END) AS carcinogenic_double_bonds FROM bond AS b INNER JOIN molecule AS m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '=';

/*
Prediction Result:
(4, 2)
*/